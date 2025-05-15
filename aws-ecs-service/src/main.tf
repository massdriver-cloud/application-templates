locals {
  region             = var.ecs_cluster.specs.aws.region
  vpc_id             = element(split("/", var.ecs_cluster.data.infrastructure.vpc.data.infrastructure.arn), 1)
  private_subnet_ids = toset([for subnet in var.ecs_cluster.data.infrastructure.vpc.data.infrastructure.private_subnets : element(split("/", subnet["arn"]), 1)])
  ecs_cluster_arn    = var.ecs_cluster.data.infrastructure.arn
  ecs_cluster_name   = element(split("/", var.ecs_cluster.data.infrastructure.arn), 1)
}

module "application" {
  source  = "github.com/massdriver-cloud/terraform-modules//massdriver-application?ref=1cc739c"
  name    = var.md_metadata.name_prefix
  service = "container"
}

resource "aws_ecs_service" "main" {
  name            = var.md_metadata.name_prefix
  cluster         = local.ecs_cluster_arn
  task_definition = aws_ecs_task_definition.main.arn
  desired_count   = var.autoscaling.min_replicas
  launch_type     = var.runtime.launch_type

  force_new_deployment = var.force_new_deployment

  network_configuration {
    subnets         = local.private_subnet_ids
    security_groups = [aws_security_group.main.id]
  }

  dynamic "load_balancer" {
    for_each = local.container_ingress_port_map
    content {
      target_group_arn = aws_lb_target_group.main[load_balancer.key].arn
      container_name   = load_balancer.value.container_name
      container_port   = load_balancer.value.container_port
    }
  }

  lifecycle {
    ignore_changes = [
      desired_count
    ]
  }
}

resource "aws_ecs_task_definition" "main" {
  family                   = var.md_metadata.name_prefix
  execution_role_arn       = aws_iam_role.execution_role.arn
  requires_compatibilities = [var.runtime.launch_type]
  network_mode             = "awsvpc"

  memory = var.runtime.memory
  cpu    = var.runtime.cpu

  task_role_arn = module.application.identity

  container_definitions = jsonencode([
    {
      name      = "main"
      image     = "${var.image.repository}:${var.image.tag}"
      cpu       = var.runtime.cpu
      memory    = var.runtime.memory
      essential = true

      environment = [for key, val in module.application.envs_and_secrets : { name = key, value = tostring(val) }]

      portMappings = [for port in var.ports :
        {
          containerPort = port.port
        }
      ]

      logConfiguration = var.monitoring.logging.destination == "disabled" ? null : {
        logDriver = var.monitoring.logging.destination
        options   = lookup(local.logging_options, var.monitoring.logging.destination, {})
      }
    }
  ])
}

resource "aws_appautoscaling_target" "main" {
  max_capacity       = var.autoscaling.max_replicas
  min_capacity       = var.autoscaling.min_replicas
  resource_id        = "service/${local.ecs_cluster_name}/${aws_ecs_service.main.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "cpu" {
  name               = "${var.md_metadata.name_prefix}-cpu-autoscaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.main.resource_id
  scalable_dimension = aws_appautoscaling_target.main.scalable_dimension
  service_namespace  = aws_appautoscaling_target.main.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value = var.autoscaling.target_cpu_percent
  }
}


module "application" {
  source = "github.com/massdriver-cloud/terraform-modules//massdriver-application-aws-ecs-service?ref=6e286e0"
  md_metadata = var.md_metadata
  ecs_cluster = var.ecs_cluster
  task_cpu    = var.resources.cpu
  task_memory = ceil(var.resources.memory)
  logging     = {
    driver = "awslogs"
    retention = 1
  }
  autoscaling = var.autoscaling
  containers = [
    {
      name = "nginx"
      image_repository = var.image.repository
      image_tag = var.image.tag
      ports = [ for port in var.ports : {
        container_port = port.port
        ingresses = [ for ingress in port.ingresses : {
          hostname   = ingress.hostname
          path       = ingress.path
          create_dns = ingress.create_dns
        }]
      }]
    }
  ]
}

module "application" {
  source               = "github.com/massdriver-cloud/terraform-modules//massdriver-application-aws-ecs-service?ref=d7b440e"
  md_metadata          = var.md_metadata
  ecs_cluster          = var.ecs_cluster
  force_new_deployment = var.force_new_deployment
  launch_type          = var.runtime.launch_type
  task_cpu             = var.runtime.cpu
  task_memory          = var.runtime.memory
  logging = {
    driver    = var.monitoring.logging.destination
    retention = lookup(var.monitoring.logging, "retention", null)
  }
  autoscaling = var.autoscaling
  containers = [
    {
      name             = "nginx"
      image_repository = var.image.repository
      image_tag        = var.image.tag
      ports = [for port in var.ports : {
        container_port = port.port
        ingresses = [for ingress in lookup(port, "ingresses", []) : {
          hostname   = ingress.hostname
          path       = ingress.path
          create_dns = ingress.create_dns
        }]
      }]
    }
  ]
}

module "lambda_application" {
  source            = "github.com/massdriver-cloud/terraform-modules//massdriver-application-aws-lambda"
  md_metadata       = var.md_metadata
  image             = var.runtime.image
  x_ray_enabled     = var.observability.x-ray.enabled
  retention_days    = var.observability.retention_days
  memory_size       = var.runtime.memory_size
  execution_timeout = var.runtime.execution_timeout
}

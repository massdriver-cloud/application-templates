locals {
  api_id = split("/", var.api_gateway.data.infrastructure.arn)[2]
}

module "lambda_application" {
  source            = "github.com/massdriver-cloud/terraform-modules//massdriver-application-aws-lambda?ref=b81fea7"
  md_metadata       = var.md_metadata
  image             = var.runtime.image
  x_ray_enabled     = var.observability.x-ray.enabled
  retention_days    = var.observability.retention_days
  memory_size       = var.runtime.memory_size
  execution_timeout = var.runtime.execution_timeout
}

resource "aws_api_gateway_resource" "main" {
  rest_api_id = local.api_id
  parent_id   = var.api_gateway.data.infrastructure.root_resource_id
  path_part   = var.api.path
}

resource "aws_api_gateway_method" "main" {
  rest_api_id   = local.api_id
  resource_id   = aws_api_gateway_resource.main.id
  http_method   = var.api.http_method
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "main" {
  rest_api_id             = local.api_id
  resource_id             = aws_api_gateway_resource.main.id
  http_method             = aws_api_gateway_method.main.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = module.lambda_application.function_invoke_arn
}

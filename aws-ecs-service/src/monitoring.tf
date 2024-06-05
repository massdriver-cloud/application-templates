locals {
  logging_options = {
    awslogs = {
      awslogs-group         = try(aws_cloudwatch_log_group.logs.0.name, "")
      awslogs-region        = local.region
      awslogs-stream-prefix = var.md_metadata.name_prefix
    }
  }
}

resource "aws_cloudwatch_log_group" "logs" {
  count             = var.monitoring.logging.destination == "awslogs" ? 1 : 0
  name              = "ecs/${var.md_metadata.name_prefix}"
  retention_in_days = var.monitoring.logging.retention
}

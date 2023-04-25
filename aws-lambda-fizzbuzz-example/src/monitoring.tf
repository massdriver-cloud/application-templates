locals {
  function_split = split(":", module.lambda_application.function_arn)
  function_name  = element(local.function_split, length(local.function_split) - 1)
  automated_alarms = {
    # Errors SUM > (Invocatiosn * (Threshold / 100))
    errors = {
      threshold = 0.1
      period    = 120
    }

    # Duration MAX = Execution Timeout)
    max_duration = {
      threshold = var.runtime.execution_timeout
      period    = 300
    }

    # Duration AVG > 80 / Timeout
    avg_duration = {
      threshold = 80 / var.runtime.execution_timeout
      period    = 300
    }
  }

  alarms_map = {
    "AUTOMATED" = local.automated_alarms
    "DISABLED"  = {}
    "CUSTOM"    = lookup(var.monitoring, "alarms", {})
  }

  alarms = lookup(local.alarms_map, var.monitoring.mode, {})
}

module "alarm_channel" {
  source      = "github.com/massdriver-cloud/terraform-modules//aws-alarm-channel?ref=8997456"
  md_metadata = var.md_metadata
}

module "errors" {
  source              = "github.com/massdriver-cloud/terraform-modules//aws/cloudwatch-alarm?ref=83c7e9d"
  sns_topic_arn       = module.alarm_channel.arn
  md_metadata         = var.md_metadata
  metric_name         = "Errors"
  display_name        = "Total Runtime Errors"
  alarm_name          = "${local.function_name} Errors"
  namespace           = "AWS/Lambda"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  period              = 60
  statistic           = "Sum"
  threshold           = 1
  message             = "Total number of runtime errors for function ${local.function_name} has exceeded 1"
  dimensions = {
    FunctionName = local.function_name
    Resource     = local.function_name
  }
}

module "errors" {
  count               = lookup(local.alarms, "errors", null) == null ? 0 : 1
  source              = "github.com/massdriver-cloud/terraform-modules//aws/cloudwatch-alarm-expression?ref=9829a65"
  sns_topic_arn       = module.alarm_channel.arn
  md_metadata         = var.md_metadata
  alarm_name          = "${var.md_metadata.name_prefix}-Errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  message             = "Lambda function ${var.md_metadata.name_prefix}: Sum Errors > % ${(local.alarms.errors.threshold)}"

  metric_queries {
    m1 = {
      metric = {
        metric_name = "Errors"
        namespace   = "AWS/Lambda"
        period      = local.alarms.errors.period
        stat        = "SUM"
        dimensions = {
          FunctionName = local.function_name
          Resource     = local.function_name
        }
      }
    }

    m2 = {
      metric = {
        metric_name = "Invocations"
        namespace   = "AWS/Lambda"
        period      = local.alarms.errors.period
        stat        = "SUM"
        dimensions = {
          FunctionName = local.function_name
          Resource     = local.function_name
        }
      }
    }

    m3 = {
      expression  = "m1 / m2"
      label       = "Errors"
      return_data = true
    }
  }
}

module "max_duration" {
  source              = "github.com/massdriver-cloud/terraform-modules//aws/cloudwatch-alarm?ref=83c7e9d"
  sns_topic_arn       = module.alarm_channel.arn
  md_metadata         = var.md_metadata
  metric_name         = "Duration"
  display_name        = "Max Duration"
  alarm_name          = "${local.function_name} Maximum Duration"
  namespace           = "AWS/Lambda"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  period              = local.alarms.max_duration.period
  statistic           = "Max"
  threshold           = local.alarms.max_duration.threshold
  message             = "The maximum duration for lambda ${local.function_name} has exceeded the runtime timeout"
  dimensions = {
    FunctionName = local.function_name
    Resource     = local.function_name
  }
}

module "avg_duration" {
  source              = "github.com/massdriver-cloud/terraform-modules//aws/cloudwatch-alarm?ref=83c7e9d"
  sns_topic_arn       = module.alarm_channel.arn
  md_metadata         = var.md_metadata
  metric_name         = "Duration"
  display_name        = "Average Duration"
  alarm_name          = "${local.function_name} Average Duration"
  namespace           = "AWS/Lambda"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  period              = local.alarms.avg_duration.period
  statistic           = "Max"
  threshold           = local.alarms.avg_duration.threshold
  message             = "The average duration for lambda ${local.function_name} has exceeded 80% of runtime timeout"
  dimensions = {
    FunctionName = local.function_name
    Resource     = local.function_name
  }
}

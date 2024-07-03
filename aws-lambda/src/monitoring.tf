locals {
  function_split = split(":", aws_lambda_function.main.arn)
  function_name  = element(local.function_split, length(local.function_split) - 1)
  automated_alarms = {
    # (Errors SUM / Invocations SUM) > Threshold
    error_rate = {
      threshold = 0.1
      period    = 120
    }

    # Duration MAX = Execution Timeout)
    max_duration = {
      threshold = (var.runtime.execution_timeout * 1000) * 0.99
      period    = 300
    }

    # Duration AVG > TimeoutMS * .8
    avg_duration = {
      threshold = (var.runtime.execution_timeout * 1000) * 0.8
      period    = 300
    }
  }

  alarms_map = {
    "AUTOMATED" = local.automated_alarms
    "DISABLED"  = {}
    "CUSTOM"    = lookup(var.observability, "alarms", {})
  }

  alarms             = lookup(local.alarms_map, var.observability.mode, {})
  monitoring_enabled = var.observability.mode != "DISABLED" ? 1 : 0
}

module "alarm_channel" {
  source      = "github.com/massdriver-cloud/terraform-modules//aws/alarm-channel?ref=a1b2019"
  md_metadata = var.md_metadata
}

module "error_rate" {
  count               = local.monitoring_enabled
  source              = "github.com/massdriver-cloud/terraform-modules//aws/cloudwatch-alarm-expression?ref=a1b2019"
  sns_topic_arn       = module.alarm_channel.arn
  md_metadata         = var.md_metadata
  alarm_name          = "${var.md_metadata.name_prefix}-ErrorRate"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  message             = "AWS Lambda ${var.md_metadata.name_prefix}: Error rate > % ${(local.alarms.error_rate.threshold)}"
  display_name        = "AWS Lambda Error Rate"
  threshold           = local.alarms.error_rate.threshold / 100
  display_metric_key  = "m1"

  metric_queries = {
    m1 = {
      metric = {
        metric_name = "Errors"
        namespace   = "AWS/Lambda"
        period      = local.alarms.error_rate.period
        stat        = "Sum"
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
        period      = local.alarms.error_rate.period
        stat        = "Sum"
        dimensions = {
          FunctionName = local.function_name
          Resource     = local.function_name
        }
      }
    }

    m3 = {
      expression  = "m1 / m2"
      label       = "Error Rate"
      return_data = true
    }
  }
}

module "max_duration" {
  count               = local.monitoring_enabled
  source              = "github.com/massdriver-cloud/terraform-modules//aws/cloudwatch-alarm?ref=a1b2019"
  sns_topic_arn       = module.alarm_channel.arn
  md_metadata         = var.md_metadata
  metric_name         = "Duration"
  display_name        = "Max Duration"
  alarm_name          = "${local.function_name} Maximum Duration"
  namespace           = "AWS/Lambda"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  period              = local.alarms.max_duration.period
  statistic           = "Maximum"
  threshold           = local.alarms.max_duration.threshold
  message             = "The maximum duration for lambda ${local.function_name} has exceeded the runtime timeout"
  dimensions = {
    FunctionName = local.function_name
    Resource     = local.function_name
  }
}

module "avg_duration" {
  count               = local.monitoring_enabled
  source              = "github.com/massdriver-cloud/terraform-modules//aws/cloudwatch-alarm?ref=a1b2019"
  sns_topic_arn       = module.alarm_channel.arn
  md_metadata         = var.md_metadata
  metric_name         = "Duration"
  display_name        = "Average Duration"
  alarm_name          = "${local.function_name} Average Duration"
  namespace           = "AWS/Lambda"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  period              = local.alarms.avg_duration.period
  statistic           = "Average"
  threshold           = local.alarms.avg_duration.threshold
  message             = "The average duration for lambda ${local.function_name} has exceeded 80% of runtime timeout"
  dimensions = {
    FunctionName = local.function_name
    Resource     = local.function_name
  }
}

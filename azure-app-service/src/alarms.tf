locals {
  automated_alarms = {
    http_4xx_metric_alert = {
      severity    = "1"
      frequency   = "PT5M"
      window_size = "PT5M"
      operator    = "GreaterThan"
      aggregation = "Average"
      threshold   = 10
    }
    http_5xx_metric_alert = {
      severity    = "0"
      frequency   = "PT5M"
      window_size = "PT5M"
      operator    = "GreaterThan"
      aggregation = "Average"
      threshold   = 5
    }
  }
  alarms_map = {
    "AUTOMATED" = local.automated_alarms
    "DISABLED"  = {}
    "CUSTOM"    = lookup(var.monitoring, "alarms", {})
  }
  alarms             = lookup(local.alarms_map, var.monitoring.mode, {})
  monitoring_enabled = var.monitoring.mode != "DISABLED" ? 1 : 0
}

resource "azurerm_log_analytics_workspace" "main" {
  name                = var.md_metadata.name_prefix
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = var.md_metadata.default_tags
}

resource "azurerm_application_insights" "main" {
  name                = var.md_metadata.name_prefix
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  workspace_id        = azurerm_log_analytics_workspace.main.id
  application_type    = "other"
  tags                = var.md_metadata.default_tags
}

module "alarm_channel" {
  source              = "github.com/massdriver-cloud/terraform-modules//azure/alarm-channel?ref=61a38e9"
  md_metadata         = var.md_metadata
  resource_group_name = azurerm_resource_group.main.name
}

module "http_4xx_metric_alert" {
  count                   = local.monitoring_enabled
  source                  = "github.com/massdriver-cloud/terraform-modules//azure/monitor-metrics-alarm?ref=61a38e9"
  scopes                  = [azurerm_linux_web_app.main.id]
  resource_group_name     = azurerm_resource_group.main.name
  monitor_action_group_id = module.alarm_channel.id
  severity                = local.alarms.http_4xx_metric_alert.severity
  frequency               = local.alarms.http_4xx_metric_alert.frequency
  window_size             = local.alarms.http_4xx_metric_alert.window_size

  depends_on = [
    azurerm_linux_web_app.main
  ]

  md_metadata  = var.md_metadata
  display_name = "HTTP 400-499 errors"
  message      = "High HTTP 400-499 errors"

  alarm_name       = "${var.md_metadata.name_prefix}-high4xxErrors"
  operator         = local.alarms.http_4xx_metric_alert.operator
  metric_name      = "Http4xx"
  metric_namespace = "microsoft.web/sites"
  aggregation      = local.alarms.http_4xx_metric_alert.aggregation
  threshold        = local.alarms.http_4xx_metric_alert.threshold
}

module "http_5xx_metric_alert" {
  count                   = local.monitoring_enabled
  source                  = "github.com/massdriver-cloud/terraform-modules//azure/monitor-metrics-alarm?ref=61a38e9"
  scopes                  = [azurerm_linux_web_app.main.id]
  resource_group_name     = azurerm_resource_group.main.name
  monitor_action_group_id = module.alarm_channel.id
  severity                = local.alarms.http_5xx_metric_alert.severity
  frequency               = local.alarms.http_5xx_metric_alert.frequency
  window_size             = local.alarms.http_5xx_metric_alert.window_size

  depends_on = [
    azurerm_linux_web_app.main
  ]

  md_metadata  = var.md_metadata
  display_name = "HTTP 500-599 errors"
  message      = "High HTTP 500-599 errors"

  alarm_name       = "${var.md_metadata.name_prefix}-high5xxErrors"
  operator         = local.alarms.http_5xx_metric_alert.operator
  metric_name      = "Http5xx"
  metric_namespace = "microsoft.web/sites"
  aggregation      = local.alarms.http_5xx_metric_alert.aggregation
  threshold        = local.alarms.http_5xx_metric_alert.threshold
}

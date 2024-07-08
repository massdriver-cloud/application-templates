
module "alarm_channel" {
  source      = "github.com/massdriver-cloud/terraform-modules//k8s/alarm-channel?ref=a1b2019"
  md_metadata = var.md_metadata
  namespace   = var.namespace
}

module "application_alarms" {
  source            = "github.com/massdriver-cloud/terraform-modules//massdriver/k8s-application-alarms?ref=a1b2019"
  md_metadata       = var.md_metadata
  deployment_alarms = true
  hpa_alarms        = var.replicas.autoscalingEnabled
}

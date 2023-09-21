module "application_alarms" {
  source            = "github.com/massdriver-cloud/terraform-modules//massdriver/k8s-application-alarms?ref=40bbc7b"
  md_metadata       = var.md_metadata
  deployment_alarms = true
  hpa_alarms        = var.replicas.autoscalingEnabled
  job_alarms        = local.migration.enabled
}

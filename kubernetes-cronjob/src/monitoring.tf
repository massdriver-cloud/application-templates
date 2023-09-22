
module "alarm_channel" {
  source      = "github.com/massdriver-cloud/terraform-modules//k8s/alarm-channel?ref=41e799c"
  md_metadata = var.md_metadata
  namespace   = var.namespace
}

module "application_alarms" {
  source      = "github.com/massdriver-cloud/terraform-modules//massdriver/k8s-application-alarms?ref=40bbc7b"
  md_metadata = var.md_metadata
  job_alarms  = true
}

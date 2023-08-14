module "helm" {
  source             = "github.com/massdriver-cloud/terraform-modules//massdriver-application-helm?ref=b4401ac"
  name               = var.md_metadata.name_prefix
  namespace          = var.namespace
  chart              = "${path.module}/chart"
  kubernetes_cluster = var.kubernetes_cluster
}

data "kubernetes_service_v1" "main" {
  metadata {
    name      = "ingress-nginx-controller"
    namespace = "md-core-services"
  }
}

module "application_alarms" {
  source            = "github.com/massdriver-cloud/terraform-modules//massdriver/k8s-application-alarms?ref=cc4fc5c"
  md_metadata       = var.md_metadata
  deployment_alarms = true
  hpa_alarms        = var.replicas.autoscalingEnabled
}
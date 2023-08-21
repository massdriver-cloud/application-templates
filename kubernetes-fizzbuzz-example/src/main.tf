
module "helm" {
  source             = "github.com/massdriver-cloud/terraform-modules//massdriver-application-helm?ref=40bbc7b"
  name               = var.md_metadata.name_prefix
  namespace          = var.namespace
  chart              = "${path.module}/chart"
  kubernetes_cluster = var.kubernetes_cluster

  helm_additional_values = {
    "massdriver-alarm-channel" = {
      "md_metadata" = var.md_metadata
    }
  }
}


data "kubernetes_service_v1" "main" {
  metadata {
    name      = "ingress-nginx-controller"
    namespace = "md-core-services"
  }
}
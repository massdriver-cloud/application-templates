
module "helm" {
  source             = "github.com/massdriver-cloud/terraform-modules//massdriver-application-helm?ref=99e7509"
  name               = var.md_metadata.name_prefix
  namespace          = var.namespace
  chart              = "${path.module}/chart"
  kubernetes_cluster = var.kubernetes_cluster
  additionalEnvs     = var.additionalEnvs
}

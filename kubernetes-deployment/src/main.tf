module "helm" {
  source             = "github.com/massdriver-cloud/terraform-modules//massdriver-application-helm?ref=23a47fa"
  name               = var.md_metadata.name_prefix
  namespace          = var.namespace
  chart              = "${path.module}/chart"
  kubernetes_cluster = var.kubernetes_cluster
  additional_envs    = []
}

module "helm" {
  source              = "github.com/massdriver-cloud/terraform-modules//massdriver-application-helm?ref=5dd4e25"
  name                = var.md_metadata.name_prefix
  namespace           = var.namespace
  chart               = "${path.module}/chart"
  kubernetes_cluster  = var.kubernetes_cluster
  additional_envs     = []
  location            = var.location
  resource_group_name = var.resource_group_name
}

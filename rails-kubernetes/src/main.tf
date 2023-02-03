module "helm" {
  source             = "github.com/massdriver-cloud/terraform-modules//massdriver-application-helm?ref=a1a0d8a563e7c0b2a4cdde7654b047a77a1effc5"
  name               = var.md_metadata.name_prefix
  namespace          = var.namespace
  chart              = "ruby-on-rails"
  helm_repository    = "https://massdriver-cloud.github.io/helm-charts/"
  helm_version       = "0.2.0"
  kubernetes_cluster = var.kubernetes_cluster
  additional_envs    = []
}

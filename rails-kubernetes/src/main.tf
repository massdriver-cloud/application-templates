module "application" {
  source  = "github.com/massdriver-cloud/terraform-modules//massdriver-application?ref=48e6b4a"
  name    = var.md_metadata.name_prefix
  service = "kubernetes"

  kubernetes = {
    namespace        = var.namespace
    cluster_artifact = var.kubernetes_cluster
  }
  resource_group_name = local.azure_resource_group_name
  location            = local.azure_location
}

resource "helm_release" "application" {
  name              = var.md_metadata.name_prefix
  chart             = "ruby-on-rails"
  repository        = "https://massdriver-cloud.github.io/helm-charts/"
  version           = "0.2.4"
  namespace         = var.namespace
  create_namespace  = true
  force_update      = true
  dependency_update = true

  values = [
    fileexists("${path.module}/chart/values.yaml") ? file("${path.module}/chart/values.yaml") : "",
    yamlencode(module.application.params),
    yamlencode(module.application.connections),
    yamlencode(local.helm_values)
  ]
}

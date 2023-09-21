locals {
  # Note: During beta migrations are hard coded to run during the API services deployment
  migration = {
    enabled = true
    command = ["bash", "-c"]
    args    = ["yarn rw prisma migrate deploy"]
    image = {
      repository = var.migration.image.repository
      tag        = var.migration.image.tag
    }
  }
}

module "helm" {
  source          = "github.com/massdriver-cloud/terraform-modules//massdriver-application-helm?ref=40bbc7b"
  name            = var.md_metadata.name_prefix
  namespace       = var.namespace
  chart           = "redwoodjs"
  helm_repository = "https://massdriver-cloud.github.io/helm-charts/"
  helm_version    = "0.1.0"

  kubernetes_cluster = var.kubernetes_cluster

  helm_additional_values = {
    # # The default command, args, and migration settings are below. Any
    # # values in values.yaml can be overwritten by adding a parameter to your massdriver.yaml
    # # or by hard coding the value here
    #     command = ["yarn"]
    #     args    = ["foo"]    
    args = []

    migration = {
      enabled = local.migration.enabled
      image = {
        repository = local.migration.image.repository
        tag        = local.migration.image.tag
      }
      command = local.migration.command
      args    = local.migration.args
    }
  }
}

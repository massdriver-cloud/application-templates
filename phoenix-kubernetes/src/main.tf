module "helm" {
  source             = "github.com/massdriver-cloud/terraform-modules//massdriver-application-helm?ref=e8bc74bed90c2bbadf1dfe2ebb8be949f2f47543"
  name               = var.md_metadata.name_prefix
  namespace          = var.namespace
  chart              = "elixir-phoenix"
  helm_repository    = "https://massdriver-cloud.github.io/helm-charts/"
  helm_version       = "0.1.4"
  kubernetes_cluster = var.kubernetes_cluster
  additional_envs    = []
  helm_additional_values = {
    # # The default command, args, and migration settings are below. Any
    # # values in values.yaml can be overwritten by adding a parameter to your massdriver.yaml
    # # or by hard coding the value here
    # command = ["mix"]
    # args    = ["phx.server"]

    # migration = {
    #   enabled = true
    #   command = ["mix"]
    #   args    = ["do", "ecto.create,", "ecto.migrate"]
    # }
  }
}

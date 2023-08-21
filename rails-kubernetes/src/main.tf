module "helm" {
  source             = "github.com/massdriver-cloud/terraform-modules//massdriver-application-helm?ref=23a47fa"
  name               = var.md_metadata.name_prefix
  namespace          = var.namespace
  chart              = "ruby-on-rails"
  helm_repository    = "https://massdriver-cloud.github.io/helm-charts/"
  helm_version       = "0.3.0"
  kubernetes_cluster = var.kubernetes_cluster
  helm_additional_values = {
    "massdriver-alarm-channel" = {
      "enabled"     = true
      "md_metadata" = var.md_metadata
    }
    # # The default command, args, and migration settings are below. Any
    # # values in values.yaml can be overwritten by adding a parameter to your massdriver.yaml
    # # or by hard coding the value here
    #     command = ["bundle"]
    #     args    = ["exec", "rails", "server"]
    #     migration = {

    #       enabled = true
    #       command = ["bash", "-c"]
    #       args = [<<ARGS
    # bundle exec rails db:create;
    # bundle exec rails db:migrate;
    # ARGS
    #       ]
    #     }
  }
}

locals {
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
  helm_values = {
    commonLabels = var.md_metadata.default_tags
    pod = {
      annotations = {
        "md-deployment-id" = lookup(module.application.params.md_metadata.deployment, "id", "")
      }
      labels = local.cloud_pod_labels[module.application.cloud]
    }
    envs = [for key, val in module.application.envs : { name = key, value = tostring(val) }]
    ingress = {
      className = "nginx" // TODO: eventually this should come from the kubernetes artifact
      annotations = {
        "cert-manager.io/cluster-issuer" : "letsencrypt-prod"     // TODO: eventually this should come from kubernetes artifact
        "nginx.ingress.kubernetes.io/force-ssl-redirect" = "true" // TODO: hardcoding this for now, dependent on nginx
      }
    }
    serviceAccount = local.cloud_service_accounts[module.application.cloud]
  }
}

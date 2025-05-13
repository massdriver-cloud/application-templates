locals {
  helm_values = {
    commonLabels = var.md_metadata.default_tags
    pod = {
      annotations = {
        "md-deployment-id" = lookup(module.application.params.md_metadata.deployment, "id", "")
      }
      labels = local.cloud_pod_labels[module.application.cloud]
    }
    envs = concat(
      [for key, val in module.application.envs : { name = key, value = tostring(val) }],
      [for key, val in module.application.secrets : { name = key, value = tostring(val) }]
    )
  }
}
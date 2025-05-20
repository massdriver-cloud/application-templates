locals {
  helm_values = {
    commonLabels = var.md_metadata.default_tags
    pod = {
      annotations = {
        "md-deployment-id" = lookup(module.application.params.md_metadata.deployment, "id", "")
      }
    }
    envs = [for key, val in module.application.envs_and_secrets : { name = key, value = tostring(val) }]
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

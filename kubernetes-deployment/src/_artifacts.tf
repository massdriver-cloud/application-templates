# TODO: remove this artifact
resource "massdriver_artifact" "debug" {
  field                = "debug"
  provider_resource_id = "debug:${timestamp()}"
  name                 = "Debugging output for app ${timestamp()}"
  artifact = jsonencode(
    {
      data = {
        vars = [
          { key = "policies", value = jsonencode(module.application.policies) },
          { key = "envs", value = jsonencode(module.application.envs) },
          { key = "cloud", value = module.application.cloud }
        ]
      }
      specs = {}
    }
  )
}

locals {
  # etc can contain any custom information you need to pass to downstream services.
  # These values are _not_ type checked by Massdriver.
  artifact_data_etc = {
    # any_fields_you_need_to_pass_downstream = "put them here"
  }

  public_artifact_data = {
    etc = local.artifact_data_etc
    api = {
      # The publicly accessible ingress hostname and path
      hostname = var.ingress.enabled ? "${var.ingress.host}${var.ingress.path}" : ""
      # By default this all traffic is redirected to HTTPS on port 443
      port     = 443
      protocol = "https"
    }
  }

  artifact_specs = {
    # An API version is required, you can set to 0.0.0 or "n/a" if you don't version your API.
    api = {
      version = "0.0.1"
    }
  }
}

resource "massdriver_artifact" "service" {
  field                = "service"
  provider_resource_id = "${var.md_metadata.name_prefix}-service"
  name                 = "Static asset server for ${var.md_metadata.name_prefix}"
  artifact = jsonencode({
    data  = local.public_artifact_data
    specs = local.artifact_specs
  })
}


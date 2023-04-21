locals {

  host     = "${local.api_id}.execute-api.${var.api_gateway.specs.aws.region}.amazonaws.com/${local.stage_name}/${var.api.path}"
  port     = 443
  protocol = "https"
  public_artifact_data = {
    api = {
      # The publicly accessible ingress hostname and path
      hostname = local.host
      # By default this all traffic is redirected to HTTPS on port 443
      port     = local.port
      protocol = local.protocol
    }
  }

  artifact_specs = {
    # An API version is required, you can set to 0.0.0 or "n/a" if you don't version your API.
    api = {
      version = "n/a"
    }
  }
}

resource "massdriver_artifact" "public" {
  field                = "public"
  provider_resource_id = "${var.md_metadata.name_prefix}-public-api"
  name                 = "Public API endpoint for ${var.md_metadata.name_prefix}"
  artifact = jsonencode({
    data  = local.public_artifact_data
    specs = local.artifact_specs
  })
}

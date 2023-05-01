locals {
  host     = try(var.ingress.host, null) == null ? "${data.kubernetes_service_v1.main.status.0.load_balancer.0.ingress.0.ip}" : "${var.ingress.host}${var.ingress.path}"
  port     = try(var.ingress.host, "") == "" ? 80 : 443
  protocol = try(var.ingress.host, "") == "" ? "http" : "https"
  public_artifact_data = {
    api = {
      # The publicly accessible ingress hostname and path
      hostname = var.ingress.enabled ? "${local.host}${var.ingress.path}" : ""
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

locals {
  dns_zone_name           = var.dns.enable_dns ? regex(".*/dns[z|Z]ones/(.*)$", var.dns.zone_id)[0] : null
  dns_zone_resource_group = var.dns.enable_dns ? regex(".*/resource[g|G]roups/(.*)/providers", var.dns.zone_id)[0] : null
  endpoint_url            = var.dns.enable_dns ? "https://${var.dns.subdomain}.${local.dns_zone_name}" : "https://"

  artifact = {
    data = {
      api = {
        hostname = local.endpoint_url
        port     = 443
      }
    }
    specs = {
      azure = {
        region = var.azure_virtual_network.specs.azure.region
      }
      api = {
        version = local.endpoint_url
      }
    }
  }
}

resource "massdriver_artifact" "endpoint" {
  field                = "endpoint"
  provider_resource_id = module.application.id
  name                 = "Application Endpoint: ${var.md_metadata.name_prefix}"
  artifact             = jsonencode(local.artifact)
}

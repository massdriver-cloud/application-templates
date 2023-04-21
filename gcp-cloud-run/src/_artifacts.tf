locals {
  dns_name = var.endpoint.enabled ? var.endpoint.zone.name : null
  endpoint = var.endpoint.enabled ? "${var.endpoint.subdomain}.${local.dns_name}" : module.application_cloud_run.hostname
}

resource "massdriver_artifact" "endpoint" {
  field                = "endpoint"
  provider_resource_id = module.application_cloud_run.id
  name                 = "GCP Cloud Run endpoint for ${var.md_metadata.name_prefix}"
  artifact = jsonencode(
    {
      data = {
        api = {
          hostname = local.endpoint
          port     = 443
        }
      }
      specs = {
        api = {
          version = "${var.container.image.name}:${var.container.image.tag}"
        }
      }
    }
  )
}

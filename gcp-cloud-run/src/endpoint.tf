module "serverless_endpoint" {
  count                  = var.endpoint.enabled ? 1 : 0
  source                 = "github.com/massdriver-cloud/terraform-modules//gcp/endpoint?ref=a1b2019"
  resource_name          = var.md_metadata.name_prefix
  labels                 = var.md_metadata.default_tags
  zone                   = var.endpoint.zone.name
  subdomain              = var.endpoint.subdomain
  location               = var.gcp_subnetwork.specs.gcp.region
  cloud_run_service_name = google_cloud_run_service.main.name
  depends_on = [
    module.apis
  ]
}

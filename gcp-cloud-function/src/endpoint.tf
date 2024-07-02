module "endpoint" {
  count                       = var.endpoint.enabled ? 1 : 0
  source                      = "github.com/massdriver-cloud/terraform-modules//gcp/endpoint?ref=a1b2019"
  resource_name               = var.md_metadata.name_prefix
  labels                      = var.md_metadata.default_tags
  location                    = local.gcp_region
  zone                        = var.endpoint.zone.name
  subdomain                   = var.endpoint.subdomain
  cloud_function_service_name = google_cloudfunctions_function.main.name
}

resource "google_cloudfunctions_function_iam_member" "invoker" {
  count          = var.endpoint.enabled ? 1 : 0
  project        = google_cloudfunctions_function.main.project
  region         = google_cloudfunctions_function.main.region
  cloud_function = google_cloudfunctions_function.main.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}

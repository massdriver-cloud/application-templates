resource "google_compute_region_network_endpoint_group" "main" {
  count                 = var.endpoint.enabled ? 1 : 0
  name                  = var.md_metadata.name_prefix
  network_endpoint_type = "SERVERLESS"
  region                = local.gcp_region
  cloud_function {
    function = google_cloudfunctions_function.main.name
  }
}

resource "google_compute_backend_service" "main" {
  count       = var.endpoint.enabled ? 1 : 0
  name        = var.md_metadata.name_prefix
  timeout_sec = 30

  backend {
    group = google_compute_region_network_endpoint_group.main[0].id
  }
}

resource "google_cloudfunctions_function_iam_member" "invoker" {
  count          = var.endpoint.enabled ? 1 : 0
  project        = google_cloudfunctions_function.main.project
  region         = google_cloudfunctions_function.main.region
  cloud_function = google_cloudfunctions_function.main.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}

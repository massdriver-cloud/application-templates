resource "google_cloud_run_service_iam_member" "public-access" {
  count    = var.endpoint.enabled ? 1 : 0
  location = google_cloud_run_service.main.location
  project  = google_cloud_run_service.main.project
  service  = google_cloud_run_service.main.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

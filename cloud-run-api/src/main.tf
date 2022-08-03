resource "google_cloud_run_service" "main" {
  name     = var.md_metadata.name_prefix
  location = local.gcp_region

  template {
    spec {
      containers {
        image = var.container_repository
      }
    }
  }
  metadata {
    annotations = {
      # For valid annotation values and descriptions, see
      # https://cloud.google.com/sdk/gcloud/reference/run/deploy#--ingress
      "run.googleapis.com/ingress" = "internal-and-cloud-load-balancing"
    }
  }
}

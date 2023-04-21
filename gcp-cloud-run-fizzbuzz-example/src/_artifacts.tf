resource "massdriver_artifact" "endpoint" {
  field                = "endpoint"
  provider_resource_id = google_cloud_run_service.main.id
  name                 = "GCP Cloud Run endpoint for ${var.md_metadata.name_prefix}"
  artifact = jsonencode(
    {
      data = {
        api = {
          hostname = google_cloud_run_service.main.status.0.url
          port     = 443
        }
      }
      specs = {
        api = {
          version = "${var.container.image.repository}:${var.container.image.tag}"
        }
      }
    }
  )
}

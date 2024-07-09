resource "google_storage_bucket" "main" {
  name                        = var.md_metadata.name_prefix
  labels                      = var.md_metadata.default_tags
  location                    = local.gcp_region
  uniform_bucket_level_access = true
}

data "archive_file" "placeholder" {
  type        = "zip"
  source_dir  = "${path.module}/files/${local.runtime_map[var.cloud_function_configuration.runtime]}"
  output_path = "${path.module}/files/placeholder-app.zip"
}

resource "google_storage_bucket_object" "main" {
  name   = "placeholder-app.zip"
  bucket = google_storage_bucket.main.name
  source = data.archive_file.placeholder.output_path
}

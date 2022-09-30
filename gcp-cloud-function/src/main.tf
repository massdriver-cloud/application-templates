module "app" {
  source   = "../../../terraform-modules/massdriver-application-gcp-cloud-function"
  name     = var.md_metadata.name_prefix
  location = var.subnetwork.specs.gcp.region
  runtime  = var.runtime
  source_archive = {
    bucket = var.source_bucket.data.infrastructure.id
    object = var.source_archive_path
  }
  cloud_function_configuration = var.cloud_function_configuration
  endpoint                     = var.endpoint
}

variable "source_bucket" {
  type = any
}

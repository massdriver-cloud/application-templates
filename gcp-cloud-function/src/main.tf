module "app" {
  source                       = "../../../terraform-modules/massdriver-application-gcp-cloud-function"
  location                     = var.subnetwork.specs.gcp.region
  runtime                      = var.runtime
  source_archive               = var.source_archive
  cloud_function_configuration = var.cloud_function_configuration
  endpoint                     = var.endpoint
  subnetwork                   = var.subnetwork.data.infrastructure.grn
}

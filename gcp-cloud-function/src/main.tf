module "application" {
  source              = "github.com/massdriver-cloud/terraform-modules//massdriver-application-gcp-cloud-function?ref=23a47fa"
  md_metadata         = var.md_metadata
  location            = var.gcp_subnetwork.specs.gcp.region
  source_archive_path = var.source_archive_path
  cloud_function_configuration = merge(var.cloud_function_configuration, {
    runtime = "python310"
  })
  endpoint      = var.endpoint
  vpc_connector = var.gcp_subnetwork.data.infrastructure.vpc_access_connector
}

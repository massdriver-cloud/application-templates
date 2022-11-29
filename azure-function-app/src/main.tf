module "application_app_service" {
  source             = "github.com/massdriver-cloud/terraform-modules//massdriver-application-azure-function-app?ref=9aab9df"
  name               = var.md_metadata.name_prefix
  application        = var.application
  docker             = var.docker
  dns                = var.dns
  network            = var.network
  monitoring         = var.monitoring
  virtual_network_id = var.azure_virtual_network.data.infrastructure.id
  location           = var.azure_virtual_network.specs.azure.region
  md_metadata        = var.md_metadata
  contact_email      = var.md_metadata.target.contact_email
  tags               = var.md_metadata.default_tags
}

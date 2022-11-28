module "application_app_service" {
  source             = "github.com/massdriver-cloud/terraform-modules//massdriver-application-azure-app-service?ref=0b16f8f"
  name               = var.md_metadata.name_prefix
  application        = var.application
  image              = var.image
  dns                = var.dns
  network            = var.network
  monitoring         = var.monitoring
  md_metadata        = var.md_metadata
  virtual_network_id = var.azure_virtual_network.data.infrastructure.id
  location           = var.azure_virtual_network.specs.azure.region
  contact_email      = var.md_metadata.target.contact_email
  tags               = var.md_metadata.default_tags
}

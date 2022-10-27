module "application_app_service" {
  source             = "github.com/massdriver-cloud/terraform-modules//massdriver-application-azure-function-app?ref=22d422e"
  name               = var.md_metadata.name_prefix
  application        = var.application
  docker             = var.docker
  dns                = var.dns
  virtual_network_id = var.azure_virtual_network.data.infrastructure.id
  location           = var.azure_virtual_network.specs.azure.region
  contact_email      = var.md_metadata.target.contact_email
  tags               = var.md_metadata.default_tags
}

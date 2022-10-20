module "application_app_service" {
  source             = "github.com/massdriver-cloud/terraform-modules//massdriver-application-azure-app-service?ref=6ed8cd7"
  name               = var.md_metadata.name_prefix
  application        = var.application
  command            = var.command
  image              = var.image
  dns                = var.dns
  location           = var.vnet.specs.azure.region
  virtual_network_id = var.vnet.data.infrastructure.id
  contact_email      = var.md_metadata.target.contact_email
  tags               = var.md_metadata.default_tags
}

module "application" {
  source             = "github.com/massdriver-cloud/terraform-modules//massdriver-application-azure-function-app?ref=23a47fa"
  name               = var.md_metadata.name_prefix
  location           = var.azure_virtual_network.specs.azure.region
  application        = var.application
  image              = var.image
  monitoring         = var.monitoring
  dns                = var.dns
  virtual_network_id = var.azure_virtual_network.data.infrastructure.id
  contact_email      = var.md_metadata.target.contact_email
  md_metadata        = var.md_metadata
  tags               = var.md_metadata.default_tags

  network = {
    auto = true
  }
  health_check = {
    path = "/health"
    port = 80
  }
}

module "application" {
  source      = "github.com/massdriver-cloud/terraform-modules//massdriver-application-azure-app-service?ref=86dc2b1"
  name        = var.md_metadata.name_prefix
  tags        = var.md_metadata.default_tags
  application = var.application
  image = var.image
  dns = var.dns
  network = {
    auto = true
  }
  health_check = {
    path = "/health"
    port = 80
  }
  monitoring = {
    mode = "AUTOMATED"
  }
  virtual_network_id = var.azure_virtual_network.data.infrastructure.id
  location           = var.azure_virtual_network.specs.azure.region
  contact_email      = var.md_metadata.target.contact_email
  md_metadata        = var.md_metadata
}

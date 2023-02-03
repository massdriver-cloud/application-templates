module "application" {
  source             = "../../terraform-modules/massdriver-application-azure-vm-docker"
  name        = var.md_metadata.name_prefix
  tags = var.md_metadata.default_tags
  virtual_network_id = var.azure_virtual_network.data.infrastructure.id
  location           = var.azure_virtual_network.specs.azure.region
  dns = var.dns
  container = var.container
  # auto_scaling = {
  #   enabled = true
  # }
  # endpoint = var.endpoint
  port = 8080
  health_check = {
    path = "/"
    port = 8080
  }
  network = {
    auto = true
  }
  monitoring = {
    mode = "AUTOMATED"
  }
  acme_registration_email_address = "massdriver"
}

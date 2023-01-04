module "application" {
  source             = "../../terraform-modules/massdriver/application-azure-vm"
  md_metadata        = var.md_metadata
  virtual_network_id = var.azure_virtual_network.data.infrastructure.id
  location           = var.location
  auto_scaling = {
    enabled = true
  }
  endpoint = var.endpoint

  health_check = {
    path = "/"
    port = 8080
  }
}

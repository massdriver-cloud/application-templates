module "application" {
  source             = "../../terraform-modules/massdriver/application-azure-vm"
  md_metadata        = var.md_metadata
  virtual_network_id = var.azure_virtual_network.data.infrastructure.id
  location           = "westus"
  auto_scaling = {
    enabled = true
  }

  health_check = {
    path = "/"
    port = 8080
  }
}

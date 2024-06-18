locals {
  virtual_network_id                  = var.azure_virtual_network.data.infrastructure.id
  virtual_network_name                = regex(".*/virtual[n|N]etworks/(.*)$", local.virtual_network_id)[0]
  virtual_network_resource_group_name = regex(".*/resource[g|G]roups/(.*)/providers", local.virtual_network_id)[0]
}

module "auto_cidr" {
  source             = "github.com/massdriver-cloud/terraform-modules//azure/auto-cidr?ref=a1b2019"
  network_mask       = 22
  virtual_network_id = local.virtual_network_id
}

resource "azurerm_subnet" "main" {
  name                 = var.md_metadata.name_prefix
  resource_group_name  = local.virtual_network_resource_group_name
  virtual_network_name = local.virtual_network_name
  address_prefixes     = [module.auto_cidr.result]
  service_endpoints    = ["Microsoft.Web", "Microsoft.Storage"]
  delegation {
    name = "virtual-network-integration"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

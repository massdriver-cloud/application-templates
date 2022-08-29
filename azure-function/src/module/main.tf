data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

resource "azurerm_linux_function_app" "main" {
  name = var.md_metadata.name_prefix
  identity {
    type = "UserAssigned"
    // use the identity in the function
    // module.application.....
    identity_ids = [azurerm_user_assigned_identity.example.id]
  }
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location

  # optional
  storage_account_name = azurerm_storage_account.main.name
  # optional
  storage_account_access_key = azurerm_storage_account.main.primary_access_key
  # required
  service_plan_id = azurerm_service_plan.main.id

  docker {
    image_name = var.container_repository.name
    image_tag  = var.container_repository.tag
  }

  # app environment variables
  # A map of key-value pairs for App Settings and custom values
  app_settings = var.envs

  site_config {}
}

resource "azurerm_storage_account" "main" {
  name                     = var.md_metadata.name_prefix
  resource_group_name      = data.azurerm_resource_group.main.name
  location                 = data.azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "main" {
  name                = var.md_metadata.name_prefix
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  os_type             = "Linux"
  sku_name            = "Y1"
}

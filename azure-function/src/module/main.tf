data "azurerm_resource_group" "main" {
  name     = var.azurerm_resource_group
  location = var.location
}

resource "azurerm_linux_function_app" "main" {
  name = var.md_metadata.name_prefix
  identity {
    type = "UserAssigned"
    // use the identity in the function
    // module.application.....
    identity_ids = [azurerm_user_assigned_identity.example.id]
  }
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  # optional
  storage_account_name = azurerm_storage_account.example.name
  # optional
  storage_account_access_key = azurerm_storage_account.example.primary_access_key
  # required
  service_plan_id = azurerm_service_plan.example.id

  docker {
    image_name = var.container_repository.name
    image_tag  = var.container_repository.tag
  }

  # app environment variables
  # A map of key-value pairs for App Settings and custom values
  app_settings = var.envs

  site_config {}
}

resource "azurerm_storage_account" "example" {
  name                     = "linuxfunctionappsa"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "example" {
  name                = "example-app-service-plan"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  os_type             = "Linux"
  sku_name            = "Y1"
}

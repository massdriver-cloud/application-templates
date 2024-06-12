resource "azurerm_user_assigned_identity" "container" {
  location            = azurerm_resource_group.main.location
  name                = "${var.md_metadata.name_prefix}-acr"
  resource_group_name = azurerm_resource_group.main.name
}

data "azurerm_client_config" "main" {
}

resource "azurerm_role_assignment" "acr" {
  scope                = "/subscriptions/${data.azurerm_client_config.main.subscription_id}"
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.container.principal_id
}

# helpful
# https://faun.pub/managed-identities-in-azure-with-terraform-28ca062ab786

locals {
  policies = {
    "read" = {
      role  = "Microsoft.Authorization/read"
      scope = ""
    }
  }
}

// start mdxc
resource "azurerm_resource_group" "main" {
  name     = var.md_metadata.name_prefix
  location = var.location
}

// create the identity
resource "azurerm_user_assigned_identity" "example" {
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  name                = var.md_metadata.name_prefix
}

// assign the roles
resource "azurerm_role_assignment" "application" {
  for_each             = local.policies
  scope                = each.value.scope
  principal_id         = azurerm_user_assigned_identity.example.principal_id
  role_definition_name = each.value.role
}
// end mdxc

module "application" {
  source  = "github.com/massdriver-cloud/terraform-modules//massdriver-application"
  name    = var.md_metadata.name_prefix
  service = "function"
}

module "azure_function" {
  source               = "./module"
  application_identity = module.application.id
  md_metadata          = var.md_metadata
  envs                 = module.application.envs
  resource_group_name  = azurerm_resource_group.main.name
}


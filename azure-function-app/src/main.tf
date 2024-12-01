locals {
  max_length           = 24
  storage_account_name = substr(replace(var.md_metadata.name_prefix, "/[^a-z0-9]/", ""), 0, local.max_length)
  contains_azurecr_io  = length(regexall("azurecr\\.io", var.image.repository)) > 0
  # Checks var.image.registry if "azurecr.io" exists. If so, captures and sets *.azurecr.io as registry_url.
  registry_url         = local.contains_azurecr_io ? regex("^(.*?azurecr\\.io)", var.image.repository)[0] : "https://index.docker.io"
  # Checks var.image.registry if "azurecr.io" exists. If so, captures and sets following namespace/image as image_name
  image_name           = local.contains_azurecr_io ? regex("^.*?azurecr\\.io/(.*)$", var.image.repository)[0] : var.image.repository
}

module "application" {
  source              = "github.com/massdriver-cloud/terraform-modules//massdriver-application?ref=48e6b4a"
  name                = var.md_metadata.name_prefix
  service             = "function"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
}

resource "azurerm_resource_group" "main" {
  name     = var.md_metadata.name_prefix
  location = var.azure_virtual_network.specs.azure.region
  tags     = var.md_metadata.default_tags
}

resource "azurerm_service_plan" "main" {
  name                   = var.md_metadata.name_prefix
  resource_group_name    = azurerm_resource_group.main.name
  location               = azurerm_resource_group.main.location
  os_type                = "Linux"
  sku_name               = var.application.sku_name
  worker_count           = var.application.zone_balancing ? (var.application.minimum_worker_count * 3) : var.application.minimum_worker_count
  zone_balancing_enabled = var.application.zone_balancing
  tags                   = var.md_metadata.default_tags
}

resource "azurerm_linux_function_app" "main" {
  name                        = var.md_metadata.name_prefix
  resource_group_name         = azurerm_resource_group.main.name
  location                    = azurerm_resource_group.main.location
  service_plan_id             = azurerm_service_plan.main.id
  functions_extension_version = "~4"
  https_only                  = true
  storage_account_name        = azurerm_storage_account.main.name
  storage_account_access_key  = azurerm_storage_account.main.primary_access_key
  virtual_network_subnet_id   = azurerm_subnet.main.id
  tags                        = var.md_metadata.default_tags

  app_settings = merge(module.application.envs, {
    /* Documented workaround for an issue with dockerized functions in the function app:
    https://github.com/Azure/azure-functions-docker/issues/642#issuecomment-1266230863
    https://learn.microsoft.com/en-us/azure/app-service/configure-custom-container?pivots=container-linux&tabs=debian#use-persistent-shared-storage */
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  })

  identity {
    type = "UserAssigned"
    identity_ids = [
      module.application.identity_block.azure_application_identity.resource_id,
      azurerm_user_assigned_identity.container.id
    ]
  }

  site_config {
    always_on                                     = true
    application_insights_connection_string        = azurerm_application_insights.main.connection_string
    application_insights_key                      = azurerm_application_insights.main.instrumentation_key
    app_scale_limit                               = var.application.maximum_worker_count
    container_registry_use_managed_identity       = true
    container_registry_managed_identity_client_id = azurerm_user_assigned_identity.container.client_id
    ftps_state                                    = "FtpsOnly"
    health_check_path                             = "/health"
    vnet_route_all_enabled                        = true

    application_stack {
      docker {
        registry_url = local.registry_url
        image_name   = local.image_name
        image_tag    = var.image.tag
      }
    }

    app_service_logs {
      disk_quota_mb         = var.application.logs.disk_quota_mb
      retention_period_days = var.application.logs.retention_period_days
    }
  }

  depends_on = [
    azurerm_service_plan.main
  ]
}

locals {
  image_split    = split("/", var.image.repository)
  image_protocol = startswith(var.image.repository, "https")
  image_registry = local.image_protocol ? "https://${local.image_split[2]}" : "https://${local.image_split[0]}"
  image_name     = local.image_protocol ? join("/", slice(local.image_split, 3, 5)) : join("/", slice(local.image_split, 1, 3))
  image_source   = length(local.image_split) > 2 ? local.image_registry : "https://docker.io/"
}

module "application" {
  source              = "github.com/massdriver-cloud/terraform-modules//massdriver-application?ref=a1b2019"
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
  location               = azurerm_resource_group.main.location
  resource_group_name    = azurerm_resource_group.main.name
  os_type                = "Linux"
  sku_name               = var.application.sku_name
  worker_count           = var.application.zone_balancing ? (var.application.minimum_worker_count * 3) : var.application.minimum_worker_count
  zone_balancing_enabled = var.application.zone_balancing
  tags                   = var.md_metadata.default_tags
}

resource "azurerm_linux_web_app" "main" {
  name                       = var.md_metadata.name_prefix
  location                   = azurerm_resource_group.main.location
  resource_group_name        = azurerm_resource_group.main.name
  service_plan_id            = azurerm_service_plan.main.id
  https_only                 = true
  client_certificate_enabled = true
  client_certificate_mode    = "Optional"
  tags                       = var.md_metadata.default_tags

  app_settings = merge(module.application.envs, {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = "${azurerm_application_insights.main.instrumentation_key}",
    "APPINSIGHTS_CONNECTION_STRING"  = "${azurerm_application_insights.main.connection_string}",
    # This environment variable enables application insights: (https://github.com/hashicorp/terraform-provider-azurerm/issues/19653#issuecomment-1347802887)
    "ApplicationInsightsAgent_EXTENSION_VERSION" = "~3",
  })

  identity {
    type = "UserAssigned"
    identity_ids = [
      module.application.identity_block.azure_application_identity.resource_id,
      azurerm_user_assigned_identity.container.id
    ]
  }

  # To get application logs, we need to set app logging level and retention.
  logs {
    failed_request_tracing  = true
    detailed_error_messages = true
    application_logs {
      file_system_level = "Error"
    }
    http_logs {
      file_system {
        retention_in_days = 7
        retention_in_mb   = 35
      }
    }
  }

  # https://learn.microsoft.com/en-us/azure/app-service/overview-vnet-integration#regional-virtual-network-integration
  virtual_network_subnet_id = azurerm_subnet.main.id

  site_config {
    always_on                                     = true
    auto_heal_enabled                             = true
    health_check_path                             = "/health"
    http2_enabled                                 = true
    container_registry_use_managed_identity       = true
    container_registry_managed_identity_client_id = azurerm_user_assigned_identity.container.client_id
    ftps_state                                    = "FtpsOnly"
    vnet_route_all_enabled                        = true

    auto_heal_setting {
      action {
        action_type = "Recycle"
      }
      trigger {
        slow_request {
          count      = 100
          interval   = "00:05:00"
          time_taken = "00:00:30"
        }
        status_code {
          count             = 10
          interval          = "00:01:00"
          status_code_range = "400-510"
        }
      }
    }

    application_stack {
      docker_registry_url = local.image_source
      docker_image_name   = "${local.image_name}:${var.image.tag}"
    }
  }

  depends_on = [
    azurerm_service_plan.main
  ]
}

terraform {
  required_providers {
    jq = {
      source = "massdriver-cloud/jq"
    }

    mdxc = {
      source  = "massdriver-cloud/mdxc"
      version = ">= 0.10.3"
    }

    massdriver = {
      source = "massdriver-cloud/massdriver"
    }

    utility = {
      source = "massdriver-cloud/utility"
    }

    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

provider "mdxc" {
  azure = {
    client_id       = var.azure_service_principal.data.client_id
    tenant_id       = var.azure_service_principal.data.tenant_id
    client_secret   = var.azure_service_principal.data.client_secret
    subscription_id = var.azure_service_principal.data.subscription_id
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }

  client_id       = var.azure_service_principal.data.client_id
  tenant_id       = var.azure_service_principal.data.tenant_id
  client_secret   = var.azure_service_principal.data.client_secret
  subscription_id = var.azure_service_principal.data.subscription_id
}

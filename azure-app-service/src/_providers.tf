terraform {
  required_providers {
    mdxc = {
      source = "massdriver-cloud/mdxc"
    }

    massdriver = {
      source = "massdriver-cloud/massdriver"
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
  features {}

  client_id       = var.azure_service_principal.data.client_id
  tenant_id       = var.azure_service_principal.data.tenant_id
  client_secret   = var.azure_service_principal.data.client_secret
  subscription_id = var.azure_service_principal.data.subscription_id
}

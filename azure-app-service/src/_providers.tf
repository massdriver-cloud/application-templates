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
    client_id       = var.azure_authentication.data.client_id
    tenant_id       = var.azure_authentication.data.tenant_id
    client_secret   = var.azure_authentication.data.client_secret
    subscription_id = var.azure_authentication.data.subscription_id
  }
}

provider "azurerm" {
  features {}

  client_id       = var.azure_authentication.data.client_id
  tenant_id       = var.azure_authentication.data.tenant_id
  client_secret   = var.azure_authentication.data.client_secret
  subscription_id = var.azure_authentication.data.subscription_id
}

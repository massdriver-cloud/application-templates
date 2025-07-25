terraform {
  required_providers {
    jq = {
      source = "massdriver-cloud/jq"
      version = "~> 0.0"
    }

    massdriver = {
      source = "massdriver-cloud/massdriver"
      version = "~> 1.0"
    }

    utility = {
      source = "massdriver-cloud/utility"
      version = "~> 0.0"
    }

    mdxc = {
      source  = "massdriver-cloud/mdxc"
      version = "~> 0.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
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

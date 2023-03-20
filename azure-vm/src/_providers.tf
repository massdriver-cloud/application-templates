terraform {
  required_providers {
    mdxc = {
      source = "massdriver-cloud/mdxc"
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

    azuread = {
      source = "hashicorp/azuread"
    }

    acme = {
      source  = "vancluever/acme"
      version = "2.12.0"
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

provider "azuread" {
  client_id     = var.azure_service_principal.data.client_id
  tenant_id     = var.azure_service_principal.data.tenant_id
  client_secret = var.azure_service_principal.data.client_secret
}

provider "acme" {
  server_url = "https://acme-v02.api.letsencrypt.org/directory"
}

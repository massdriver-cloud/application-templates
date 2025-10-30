terraform {
  required_version = ">= 1.0"
  required_providers {
    massdriver = {
      source  = "massdriver-cloud/massdriver"
      version = "~> 1.0"
    }
    # aws = {
    #   source  = "hashicorp/aws"
    #   version = "~> 6.0"
    # }
    # azurerm = {
    #   source  = "hashicorp/azurerm"
    #   version = "~> 4.0"
    # }
    # google = {
    #   source  = "hashicorp/google"
    #   version = "~> 7.0"
    # }
  }
}

# provider "aws" {
#   region     = var.region
#   assume_role {
#     role_arn    = var.aws_authentication.data.arn
#     external_id = var.aws_authentication.data.external_id
#   }
#   default_tags {
#     tags = var.md_metadata.default_tags
#   }
# }

# provider "azurerm" {
#   features {}

#   client_id       = var.azure_service_principal.data.client_id
#   tenant_id       = var.azure_service_principal.data.tenant_id
#   client_secret   = var.azure_service_principal.data.client_secret
#   subscription_id = var.azure_service_principal.data.subscription_id
# }

# provider "google" {
#   project     = var.gcp_authentication.data.project_id
#   credentials = jsonencode(var.gcp_authentication.data)
#   region      = var.region
# }
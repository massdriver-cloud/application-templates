terraform {
  required_version = ">= 1.0"
  required_providers {
    massdriver = {
      source  = "massdriver-cloud/massdriver"
      version = "~> 1.0"
    }
    # aws = {
    #   source  = "hashicorp/aws"
    #   version = "~> 4.0"
    # }
    # azurerm = {
    #   source  = "hashicorp/azurerm"
    #   version = "~> 3.0"
    # }
    # google = {
    #   source  = "hashicorp/google"
    #   version = "~> 4.0"
    # }
    # google-beta = {
    #   source  = "hashicorp/google-beta"
    #   version = "~> 4.0"
    # }
    # helm = {
    #   source  = "hashicorp/helm"
    #   version = "~> 2.0"
    # }
    # kubernetes = {
    #   source  = "hashicorp/kubernetes"
    #   version = "~> 2.0"
    # }
  }
}

# provider "aws" {
#   region     = var.network.specs.aws.region
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
#   region      = var.mrc.specs.gcp.region
# }

# provider "google-beta" {
#   project     = var.gcp_authentication.data.project_id
#   credentials = jsonencode(var.gcp_authentication.data)
#   region      = var.mrc.specs.gcp.region
# }

# provider "helm" {
#   kubernetes {
#     config_context = "default"
#     config_path = "kube.yaml"
#   }
# }

# provider "kubernetes" {
#   config_context = "default"
#   config_path = "kube.yaml"
# }

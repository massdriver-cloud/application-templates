terraform {
  required_version = ">= 1.0"
  required_providers {
    massdriver = {
      source  = "massdriver-cloud/massdriver"
      version = "~> 1.1"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 4.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

locals {
  gcp_region     = var.subnetwork.specs.gcp.region
  gcp_project_id = var.gcp_authentication.data.project_id
}

provider "google" {
  project     = local.gcp_project_id
  credentials = jsonencode(var.gcp_authentication.data)
  region      = local.gcp_region
}

provider "google-beta" {
  project     = local.gcp_project_id
  credentials = jsonencode(var.gcp_authentication.data)
  region      = local.gcp_region
}

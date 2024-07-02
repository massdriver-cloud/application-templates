terraform {
  required_version = ">= 1.0"
  required_providers {
    mdxc = {
      source = "massdriver-cloud/mdxc"
    }
    massdriver = {
      source = "massdriver-cloud/massdriver"
    }
    google = {
      source = "hashicorp/google"
    }
    google-beta = {
      source = "hashicorp/google-beta"
    }
    null = {
      source = "hashicorp/null"
    }
  }
}

locals {
  gcp_project_id  = var.gcp_authentication.data.project_id
  gcp_credentials = jsonencode(var.gcp_authentication.data)
  gcp_region      = var.gcp_subnetwork.specs.gcp.region
}

provider "google" {
  project     = local.gcp_project_id
  credentials = local.gcp_credentials
  region      = local.gcp_region
}

provider "google-beta" {
  project     = local.gcp_project_id
  credentials = local.gcp_credentials
  region      = local.gcp_region
}

provider "mdxc" {
  gcp = {
    project     = local.gcp_project_id
    credentials = local.gcp_credentials
  }
}

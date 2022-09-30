terraform {
  required_version = ">= 1.0"
  required_providers {
    mdxc = {
      source = "massdriver-cloud/mdxc"
    }
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
  gcp_project_id  = var.gcp_authentication.data.project_id
  gcp_credentials = jsonencode(var.gcp_authentication.data)
}

provider "google" {
  project     = local.gcp_project_id
  credentials = local.gcp_credentials
}

provider "google-beta" {
  project     = local.gcp_project_id
  credentials = local.gcp_credentials
}

provider "mdxc" {
  gcp = {
    project     = local.gcp_project_id
    credentials = local.gcp_credentials
  }
}

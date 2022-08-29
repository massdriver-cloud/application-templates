terraform {
  required_version = ">= 1.0"
  required_providers {
    mdxc = {
      source  = "massdriver-cloud/mdxc"
      version = "0.0.4"
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
  gcp_project_id = var.gcp_authentication.data.project_id
}

provider "google" {
  project     = local.gcp_project_id
  credentials = jsonencode(var.gcp_authentication.data)
}

provider "google-beta" {
  project     = local.gcp_project_id
  credentials = jsonencode(var.gcp_authentication.data)
}

provider "mdxc" {
  gcp = {
    project     = local.gcp_project_id
    credentials = jsonencode(var.gcp_authentication.data)
  }
}

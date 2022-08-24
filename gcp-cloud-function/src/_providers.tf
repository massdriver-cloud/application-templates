terraform {
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
      source = "hashicopr/google-beta"
    }
  }
}

locals {
  gcp_region     = var.subnetwork.specs.gcp.region
  gcp_project_id = var.gcp_authentication.data.project_id
}

provider "mdxc" {
  gcp = {
    credentials      = jsonencode(var.gcp_authentication.data)
    project    = local.gcp_project_id
  }
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

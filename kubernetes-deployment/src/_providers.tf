terraform {
  required_version = ">= 1.0"
  required_providers {
    mdxc = {
      source = "massdriver-cloud/mdxc"
    }
    jq = {
      source = "massdriver-cloud/jq"
    }
    helm = {
      source = "hashicorp/helm"
    }
  }
}

provider "mdxc" {
  # aws = {
  #   role_arn    = var.aws_authentication.data.arn
  #   external_id = var.aws_authentication.data.external_id
  #   region      = var.aws_authentication.specs.aws.region
  # }
  # azure = {
  #   subscription_id = var.azure_authentication.data.subscription_id
  #   client_id       = var.azure_authentication.data.client_id
  #   client_secret   = var.azure_authentication.data.client_secret
  #   tenant_id       = var.azure_authentication.data.tenant_id
  # }
  # gcp = {
  #   credentials = jsonencode(var.gcp_authentication.data)
  #   project     = var.gcp_authentication.data.project_id
  # }
}

provider "helm" {
  kubernetes {
    host                   = var.kubernetes_cluster.data.authentication.cluster.server
    cluster_ca_certificate = base64decode(var.kubernetes_cluster.data.authentication.cluster.certificate-authority-data)
    token                  = var.kubernetes_cluster.data.authentication.user.token
  }
}

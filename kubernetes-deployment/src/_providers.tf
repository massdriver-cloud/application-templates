terraform {
  required_providers {
    jq = {
      source = "massdriver-cloud/jq"
    }

    massdriver = {
      source = "massdriver-cloud/massdriver"
    }

    mdxc = {
      source = "massdriver-cloud/mdxc"
      version = ">= 0.10.3"
    }

    helm = {
      source = "hashicorp/helm"
    }
  }
}

locals {
  # Note: If the field name `kubernetes_cluster` in massdriver.yaml has been changed, this must be updated to match.
  kubernetes_cluster = var.kubernetes_cluster
  cloud              = local.kubernetes_cluster.specs.kubernetes.cloud
}

provider "mdxc" {
  azure = local.cloud == "azure" ? {
    client_id       = var.azure_authentication.data.client_id
    tenant_id       = var.azure_authentication.data.tenant_id
    client_secret   = var.azure_authentication.data.client_secret
    subscription_id = var.azure_authentication.data.subscription_id
  } : null

  gcp = local.cloud == "gcp" ? {
    project     = var.gcp_authentication.data.project_id
    credentials = jsonencode(var.gcp_authentication.data)
    region      = split("/", local.kubernetes_cluster.data.infrastructure.grn)[3]
  } : null

  aws = local.cloud == "aws" ? {
    region      = element(split(":", local.kubernetes_cluster.data.infrastructure.arn), 3)
    role_arn    = var.aws_authentication.data.arn
    external_id = var.aws_authentication.data.external_id
  } : null
}

provider "helm" {
  kubernetes {
    host                   = local.kubernetes_cluster.data.authentication.cluster.server
    cluster_ca_certificate = base64decode(local.kubernetes_cluster.data.authentication.cluster.certificate-authority-data)
    token                  = local.kubernetes_cluster.data.authentication.user.token
  }
}

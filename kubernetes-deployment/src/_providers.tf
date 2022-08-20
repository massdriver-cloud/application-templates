terraform {
  required_providers {
    mdxc = {
      source = "massdriver-cloud/mdxc"
    }

    massdriver = {
      source = "massdriver-cloud/massdriver"
    }

    helm = {
      source = "hashicorp/helm"
    }
  }
}

locals {
  # Note: If the field name `kubernetes_cluster` in massdriver.yaml has been changed, these must be updated to match.
  kubernetes_cluster_auth = var.kubernetes_cluster.data.authentication
  kubernetes_cloud        = var.kubernetes_cluster.specs.kubernetes.cloud
}

provider "mdxc" {
  # TODO: auth will still be borked as the fields may not be present in, we'll need to use a lot of lookups
  azure = local.kubernetes_cloud == "azure" ? null : null
  gcp   = local.kubernetes_cloud == "gcp" ? null : null
  aws = local.kubernetes_cloud == "aws" ? {
    # TODO: need to ge this dynamically
    region      = "us-west-2"
    role_arn    = var.aws_authentication.data.arn
    external_id = var.aws_authentication.data.external_id
  } : null
}

provider "helm" {
  kubernetes {
    host                   = local.kubernetes_cluster_auth.cluster.server
    cluster_ca_certificate = base64decode(local.kubernetes_cluster_auth.certificate-authority-data)
    token                  = local.kubernetes_cluster_auth.user.token
  }
}

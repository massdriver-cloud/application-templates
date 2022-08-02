<md if (eq .CloudProvider "aws") md>
terraform {
  required_version = ">= 1.0"
  required_providers {
    massdriver = {
      source = "massdriver-cloud/massdriver"
    }
    jq = {
      source = "massdriver-cloud/jq"
    }
    aws = {
      source = "hashicorp/aws"
    }
    helm = {
      source = "hashicorp/helm"
    }
  }
}

locals {
  aws_authentication = module.k8s_application.connections.aws_authentication
  kubernetes_cluster = module.k8s_application.connections.kubernetes_cluster
  k8s_cluster_name   = split("/", local.kubernetes_cluster.data.infrastructure.arn)[1]
  region_hack        = split(":", local.kubernetes_cluster.data.infrastructure.arn)[3]
}

data "aws_eks_cluster" "cluster" {
  name = local.k8s_cluster_name
}

data "aws_eks_cluster_auth" "auth" {
  name = local.k8s_cluster_name
}

provider "aws" {
  region = local.region_hack
  assume_role {
    role_arn    = local.aws_authentication.data.arn
    external_id = local.aws_authentication.data.external_id
  }
  default_tags {
    tags = module.k8s_application.params.md_metadata.default_tags
  }
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
    # token                  = local.kubernetes_cluster.data.authentication.user.token
    # this returns a value that doesn't work for the cluster
    # I'm not sure if it's the creds I used in the AWS provider
    # but I tried to use the ones that made the cluster
    # in GCP, we use all fields from the artifact, what are your thoughts on this?
    token = data.aws_eks_cluster_auth.auth.token
  }
}
<md end md>

<md if (eq .CloudProvider "azure") md>
terraform {
  required_version = ">= 1.0"
  required_providers {
    massdriver = {
      source = "massdriver-cloud/massdriver"
    }
    jq = {
      source = "massdriver-cloud/jq"
    }
    azurerm = {
      source = "hashicorp/azurerm"
    }
    azuread = {
      source = "hashicorp/azuread"
    }
    helm = {
      source = "hashicorp/helm"
    }
  }
}

locals {
  azure_authentication         = module.k8s_application.connections.azure_authentication
  kubernetes_cluster_split_ari = split("/", module.k8s_application.connections.kubernetes_cluster.data.infrastructure.ari)
  kubernetes_cluster_name      = local.kubernetes_cluster_split_ari[index(local.kubernetes_cluster_split_ari, "managedClusters") + 1]
  resource_group_name          = local.kubernetes_cluster_split_ari[index(local.kubernetes_cluster_split_ari, "resourceGroups") + 1]
}

data "azurerm_kubernetes_cluster" "cluster" {
  name                = local.kubernetes_cluster_name
  resource_group_name = local.resource_group_name
}

provider "azurerm" {
  features {}

  client_id       = local.azure_authentication.data.client_id
  tenant_id       = local.azure_authentication.data.tenant_id
  client_secret   = local.azure_authentication.data.client_secret
  subscription_id = local.azure_authentication.data.subscription_id
}

provider "azuread" {
  client_id     = local.azure_authentication.data.client_id
  tenant_id     = local.azure_authentication.data.tenant_id
  client_secret = local.azure_authentication.data.client_secret
}

provider "helm" {
  kubernetes {
    host                   = data.azurerm_kubernetes_cluster.cluster.kube_config.0.host
    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_admin_config.0.client_certificate)
    client_key             = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_admin_config.0.client_key)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_config.0.cluster_ca_certificate)
  }
}
<md end md>

<md if (eq .CloudProvider "gcp") md>
terraform {
  required_version = ">= 1.0"
  required_providers {
    massdriver = {
      source = "massdriver-cloud/massdriver"
    }
    jq = {
      source = "massdriver-cloud/jq"
    }
    google = {
      source = "hashicorp/google"
    }
    helm = {
      source = "hashicorp/helm"
    }
  }
}

locals {
  gcp_authentication = module.k8s_application.connections.gcp_authentication
  kubernetes_cluster = module.k8s_application.connections.kubernetes_cluster
  gcp_region         = split("/", local.kubernetes_cluster.data.infrastructure.grn)[3]
  gcp_project_id     = local.gcp_authentication.data.project_id

  k8s_host                  = local.kubernetes_cluster.data.authentication.cluster.server
  k8s_certificate_authority = base64decode(local.kubernetes_cluster.data.authentication.cluster.certificate-authority-data)
  k8s_token                 = local.kubernetes_cluster.data.authentication.user.token
}

provider "google" {
  project     = local.gcp_project_id
  credentials = jsonencode(local.gcp_authentication.data)
  region      = local.gcp_region
}

provider "helm" {
  kubernetes {
    host                   = local.k8s_host
    cluster_ca_certificate = local.k8s_certificate_authority
    token                  = local.k8s_token
  }
}
<md end md>

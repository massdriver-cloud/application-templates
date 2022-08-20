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

provider "mdxc" {
  azure = null
  gcp   = null
  aws = {
    # TODO: need to ge this dynamically
    # NBD, this will be in the provider.tf file for each template. In k8s we cna reach from the cluster, in labmda, etc we can read from params.region or vpc
    region = "us-west-2"

    # we'll ned a bunch of logic to figure out the auth in the template.
    role_arn    = var.aws_authentication.data.arn
    external_id = var.aws_authentication.data.external_id
  }
}

# TODO: sniff this from kubernetes_cluster
# provider "helm" {
#   kubernetes {
#     host                   = data.aws_eks_cluster.cluster.endpoint
#     cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
#     # token                  = local.kubernetes_cluster.data.authentication.user.token
#     # this returns a value that doesn't work for the cluster
#     # I'm not sure if it's the creds I used in the AWS provider
#     # but I tried to use the ones that made the cluster
#     # in GCP, we use all fields from the artifact, what are your thoughts on this?
#     token = data.aws_eks_cluster_auth.auth.token
#   }
# }

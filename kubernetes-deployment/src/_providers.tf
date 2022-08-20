terraform {
  required_providers {
    mdxc = {
      source = "massdriver-cloud/mdxc"
    }

    massdriver = {
      source = "massdriver-cloud/massdriver"
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

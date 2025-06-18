terraform {
  required_providers {
    mdxc = {
      source = "massdriver-cloud/mdxc"
      version = "~> 0.0"
    }

    massdriver = {
      source = "massdriver-cloud/massdriver"
      version = "~> 1.0"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "mdxc" {
  aws = {
    region      = var.ecs_cluster.specs.aws.region
    role_arn    = var.aws_authentication.data.arn
    external_id = var.aws_authentication.data.external_id
  }
}

provider "aws" {
  region = var.ecs_cluster.specs.aws.region
  assume_role {
    role_arn    = var.aws_authentication.data.arn
    external_id = var.aws_authentication.data.external_id
  }
  default_tags {
    tags = var.md_metadata.default_tags
  }
}

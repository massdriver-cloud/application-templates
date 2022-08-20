# TODO: chart name comes from var.md_metadata.name_prefix
# TODO: feed env vars to helm chart from module.application.envs (and merge w/ param.envs if we want to keep this, im not a fan)
# TODO: make sure the 'host' field is actually just the subdomain, k8s will be handling the zone. Make this clear in the description
# TODO: I dont see any external-dns in the chart...
# TODO: add helm resource

module "application" {
  source = "github.com/massdriver-cloud/terraform-modules//massdriver-application"
  name   = var.md_metadata.name_prefix

  # TODO: this will need to be finagled per cloud type to get the right k8s bits.
  # This could be moved into the module w/ a simpler api here like
  # service = "ec2" | "lambda" | "k8s:the-data-in-some-consisten-way-that-the-module-can-parse"
  identity = {
    assume_role_policy = <<EOF
{
		"Version": "2012-10-17",
		"Statement": [
			{
				"Effect": "Allow",
				"Action": [
					"sts:AssumeRole"
				],
				"Principal": {
					"Service": [
						"ec2.amazonaws.com"
					]
				}
			}
		]
	}
   EOF
  }
}

locals {
  helm_additional_values = {
    envs = module.application.envs
    ingress = {
      className = "nginx" // eventually this should come from the kubernetes artifact
      annotations = {
        "cert-manager.io/cluster-issuer" : "letsencrypt-prod"     // eventually this should come from kubernetes artifact
        "nginx.ingress.kubernetes.io/force-ssl-redirect" = "true" // hardcoding this for now, dependent on nginx
      }
    }
  }
}

resource "helm_release" "application" {
  name             = var.md_metadata.name_prefix
  chart            = "${path.module}/chart"
  namespace        = var.namespace
  create_namespace = true
  force_update     = true

  values = [
    fileexists("${path.module}/chart/values.yaml") ? file("${path.module}/chart/values.yaml") : "",
    yamlencode(module.application.params),
    yamlencode(local.helm_additional_values)
  ]
}

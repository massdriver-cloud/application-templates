# TODO: do any gnarly ternaries and locals we have to, then package this up as a module so its not error prone in templates.

locals {
  base_helm_additional_values = {
    envs = module.application.envs
    ingress = {
      className = "nginx" // eventually this should come from the kubernetes artifact
      annotations = {
        "cert-manager.io/cluster-issuer" : "letsencrypt-prod"     // eventually this should come from kubernetes artifact
        "nginx.ingress.kubernetes.io/force-ssl-redirect" = "true" // hardcoding this for now, dependent on nginx
      }
    }
  }

  aws_additional_values = merge(local.base_helm_additional_values, {
    serviceAccount = {
      annotations = {
        "eks.amazonaws.com/role-arn" = module.application.id
      }
    }
  })

  gcp_additional_values = merge(local.base_helm_additional_values, {
    serviceAccount = {
      annotations = {
        "iam.gke.io/gcp-service-account" = module.application.id
      }
    }
  })

  # TODO: Add azure, I dont think this has an annotation equiv, will probably be ENV Vars w/ secret
  azure_additional_values = merge(local.base_helm_additional_values, {})

  cloud_specific_helm_additional_values = {
    aws   = local.aws_additional_values,
    gcp   = local.gcp_additional_values,
    azure = local.azure_additional_values
  }

  helm_additional_values = local.cloud_specific_helm_additional_values[module.application.cloud]
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

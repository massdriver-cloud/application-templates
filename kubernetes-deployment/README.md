# massdriver-application-helm

Helm implementation of [`massdriver-application`](../massdriver-application).

This module:
* configures an application's IAM for a specific service to run on Massdriver provisioned infrastructure in a cloud agnostic way
* deploys your helm chart in a cloud agnostic way

It creates an IAM Role or Service Account (depending on the cloud), gives permissions to the cloud services (lambda, ec2, k8s) to assume the role, and binds application level permissions from massdriver artifacts' security policies (SQS, S3, etc).

It also parses `policies` and `envs` from the _massdriver.yaml_ `app` field.

It provides a means to design applications in Massdriver to be cloud agnostic.

## Example

*Deploying a kubernetes workload*:

```hcl
module "helm" {
  source             = "github.com/massdriver-cloud/terraform-modules//massdriver-application-helm"
  name               = var.md_metadata.name_prefix
  namespace          = var.namespace
  chart              = "${path.module}/chart"
  kubernetes_cluster = var.kubernetes_cluster
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.11.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_application"></a> [application](#module\_application) | github.com/massdriver-cloud/terraform-modules//massdriver-application | 61a38e9 |

## Resources

| Name | Type |
|------|------|
| [helm_release.application](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chart"></a> [chart](#input\_chart) | The path to your Helm chart | `string` | n/a | yes |
| <a name="input_helm_additional_values"></a> [helm\_additional\_values](#input\_helm\_additional\_values) | Additional helm values to set | `any` | `{}` | no |
| <a name="input_helm_repository"></a> [helm\_repository](#input\_helm\_repository) | (Optional) The chart's helm repository. Required when not using a local chart. | `string` | `null` | no |
| <a name="input_helm_version"></a> [helm\_version](#input\_helm\_version) | (Optional) The helm chart version. Required when not using a local chart. | `string` | `null` | no |
| <a name="input_kubernetes_cluster"></a> [kubernetes\_cluster](#input\_kubernetes\_cluster) | Massdriver Kubernetes Cluster Artifact | `any` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The release name of the chart, this should be your var.md\_metadata.name\_prefix | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace to deploy chart into | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_identity"></a> [identity](#output\_identity) | Cloud ID for application IAM (AWS Role, GCP Service Account, Azure Managed Identity ID, etc) |
| <a name="output_secrets"></a> [secrets](#output\_secrets) | Secrets from the bundle configuration |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

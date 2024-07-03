# AWS Lambda Application

Provisions an aws lambda function configured to write logs to cloudwatch and assigned a workload identity for interaction with various aws services.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_application"></a> [application](#module\_application) | github.com/massdriver-cloud/terraform-modules//massdriver-application | 61a38e9 |
| <a name="module_aws_lambda_function"></a> [aws\_lambda\_function](#module\_aws\_lambda\_function) | github.com/massdriver-cloud/terraform-modules//aws/aws-lambda-function | 61a38e9 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_execution_timeout"></a> [execution\_timeout](#input\_execution\_timeout) | Timeout period in seconds | `number` | `3` | no |
| <a name="input_image"></a> [image](#input\_image) | Docker image URI and tag | <pre>object({<br>    uri = string<br>    tag = string<br>  })</pre> | n/a | yes |
| <a name="input_md_metadata"></a> [md\_metadata](#input\_md\_metadata) | Massdriver metadata which is provided by the Massdriver deployment runtime | `any` | n/a | yes |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | Upper limit of memory in MB | `number` | `128` | no |
| <a name="input_retention_days"></a> [retention\_days](#input\_retention\_days) | Retention time for execution logs in days | `number` | `7` | no |
| <a name="input_x_ray_enabled"></a> [x\_ray\_enabled](#input\_x\_ray\_enabled) | Enable AWS native tracing via X-Ray | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_function_arn"></a> [function\_arn](#output\_function\_arn) | The amazon resource name of the function that was created |
| <a name="output_function_invoke_arn"></a> [function\_invoke\_arn](#output\_function\_invoke\_arn) | The Amazon Resource Name of the invocation API |
| <a name="output_identity"></a> [identity](#output\_identity) | Cloud ID for application IAM. For AWS this is an IAM Role ARN. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

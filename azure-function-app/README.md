<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_mdxc"></a> [mdxc](#requirement\_mdxc) | >= 0.10.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.81.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alarm_channel"></a> [alarm\_channel](#module\_alarm\_channel) | github.com/massdriver-cloud/terraform-modules//azure/alarm-channel | 61a38e9 |
| <a name="module_application"></a> [application](#module\_application) | github.com/massdriver-cloud/terraform-modules//massdriver-application | 61a38e9 |
| <a name="module_auto_cidr"></a> [auto\_cidr](#module\_auto\_cidr) | github.com/massdriver-cloud/terraform-modules//azure/auto-cidr | 2d85f7a |
| <a name="module_dns"></a> [dns](#module\_dns) | github.com/massdriver-cloud/terraform-modules//azure/dns | 9df7459 |
| <a name="module_latency_metric_alert"></a> [latency\_metric\_alert](#module\_latency\_metric\_alert) | github.com/massdriver-cloud/terraform-modules//azure/monitor-metrics-alarm | 61a38e9 |

## Resources

| Name | Type |
|------|------|
| [azurerm_application_insights.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) | resource |
| [azurerm_linux_function_app.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_function_app) | resource |
| [azurerm_monitor_autoscale_setting.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_resource_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_service_plan.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |
| [azurerm_storage_account.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_subnet.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_user_assigned_identity.container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_client_config.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application"></a> [application](#input\_application) | n/a | <pre>object({<br>    sku_name             = string<br>    minimum_worker_count = number<br>    maximum_worker_count = number<br>    zone_balancing       = bool<br>    logs = object({<br>      retention_period_days = number<br>      disk_quota_mb         = number<br>    })<br>  })</pre> | n/a | yes |
| <a name="input_contact_email"></a> [contact\_email](#input\_contact\_email) | n/a | `string` | n/a | yes |
| <a name="input_dns"></a> [dns](#input\_dns) | n/a | `any` | n/a | yes |
| <a name="input_health_check"></a> [health\_check](#input\_health\_check) | n/a | <pre>object({<br>    port = optional(number, 80)<br>    path = optional(string, "/")<br>  })</pre> | n/a | yes |
| <a name="input_image"></a> [image](#input\_image) | n/a | <pre>object({<br>    registry = string<br>    name     = string<br>    tag      = string<br>  })</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_md_metadata"></a> [md\_metadata](#input\_md\_metadata) | n/a | `any` | n/a | yes |
| <a name="input_monitoring"></a> [monitoring](#input\_monitoring) | n/a | <pre>object({<br>    mode = string<br>  })</pre> | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | n/a | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `any` | n/a | yes |
| <a name="input_virtual_network_id"></a> [virtual\_network\_id](#input\_virtual\_network\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_hostname"></a> [hostname](#output\_hostname) | Default hostname for the application runtime |
| <a name="output_identity"></a> [identity](#output\_identity) | Cloud ID for application IAM. For Azure this is the Managed Identity ID. |
| <a name="output_resource_id"></a> [resource\_id](#output\_resource\_id) | Cloud Resource ID for the resource |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# massdriver-application-aws-ecs-service

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.26.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_application"></a> [application](#module\_application) | github.com/massdriver-cloud/terraform-modules//massdriver-application | 61a38e9 |

## Resources

| Name | Type |
|------|------|
| [aws_appautoscaling_policy.cpu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_target.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_cloudwatch_log_group.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ecs_service.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_role.execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lb_listener_rule.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_target_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_route53_record.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_security_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.alb_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.all_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_iam_policy_document.execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_lb.lookup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/lb) | data source |
| [aws_route53_zone.lookup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_autoscaling"></a> [autoscaling](#input\_autoscaling) | Autoscaling Configuration | <pre>object({<br>    min_replicas       = number<br>    max_replicas       = number<br>    target_cpu_percent = number<br>  })</pre> | n/a | yes |
| <a name="input_containers"></a> [containers](#input\_containers) | Container | <pre>list(object({<br>    name             = string<br>    image_repository = string<br>    image_tag        = string<br>    cpu              = optional(number)<br>    memory           = optional(number)<br>    command          = optional(list(string))<br>    arguments        = optional(list(string))<br>    ports = list(object({<br>      container_port = number<br>      ingresses = list(object({<br>        hostname   = string<br>        path       = string<br>        create_dns = bool<br>      }))<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_ecs_cluster"></a> [ecs\_cluster](#input\_ecs\_cluster) | Massdriver ECS Cluster Artifact | `any` | n/a | yes |
| <a name="input_force_new_deployment"></a> [force\_new\_deployment](#input\_force\_new\_deployment) | Enable to force a new task deployment of the service. This can be used to update tasks to use a newer Docker image with same image/tag combination. | `bool` | `false` | no |
| <a name="input_launch_type"></a> [launch\_type](#input\_launch\_type) | Launch type on which to run your service. The valid values are `EC2` and `FARGATE`. Default is `EC2` | `string` | `"EC2"` | no |
| <a name="input_logging"></a> [logging](#input\_logging) | Logging configuration | <pre>object({<br>    driver    = string<br>    retention = optional(number)<br>  })</pre> | <pre>{<br>  "driver": "disabled"<br>}</pre> | no |
| <a name="input_md_metadata"></a> [md\_metadata](#input\_md\_metadata) | Massdriver metadata block | `any` | n/a | yes |
| <a name="input_task_cpu"></a> [task\_cpu](#input\_task\_cpu) | Task CPU resources | `number` | n/a | yes |
| <a name="input_task_memory"></a> [task\_memory](#input\_task\_memory) | Task Memory resources | `number` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_identity"></a> [identity](#output\_identity) | Cloud ID for application IAM. For AWS this is an IAM Role ARN. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

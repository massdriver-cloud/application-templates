########
## Uncomment below to enable producing artifacts for your web service.
## You only need to uncomment the following if you intend to connect your internal services in Massdriver.
## You will also need to uncomment the corresponding artifacts in `massdriver.yaml`.
########
#
# locals {
#   dns_name = var.endpoint.enabled ? var.endpoint.zone.name : null
#   endpoint = var.endpoint.enabled ? "${var.endpoint.subdomain}.${local.dns_name}" : module.application.hostname
# }
#
# resource "massdriver_artifact" "endpoint" {
#   field                = "endpoint"
#   provider_resource_id = module.application.grn
#   name                 = "GCP Cloud Run endpoint for ${var.md_metadata.name_prefix}"
#   artifact = jsonencode(
#     {
#       data = {
#         api = {
#           hostname = local.endpoint
#           port     = 443
#         }
#       }
#       specs = {
#         api = {
#           version = "${var.container.image.repository}:${var.container.image.tag}"
#         }
#       }
#     }
#   )
# }

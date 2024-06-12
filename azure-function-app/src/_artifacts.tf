########
## Uncomment below to enable producing artifacts for your web service.
## You only need to uncomment the following if you intend to connect your internal services in Massdriver.
## You will also need to uncomment the corresponding artifacts in `massdriver.yaml`.
########

# locals {
#   endpoint = var.dns.enable_dns ? "${var.dns.subdomain}.${local.dns_zone}" : module.application.hostname
#   dns_zone = var.dns.enable_dns ? element(split("/", var.dns.zone_id), index(split("/", var.dns.zone_id), "dnszones") + 1) : null
# }
#
# resource "massdriver_artifact" "endpoint" {
#   field                = "endpoint"
#   provider_resource_id = module.application.resource_id
#   name                 = "Azure Function App endpoint for ${var.md_metadata.name_prefix}"
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
#           version = "${var.image.name}:${var.image.tag}"
#         }
#       }
#     }
#   )
# }

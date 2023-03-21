########
## Uncomment below to enable producing artifacts for your web service.
## You only need to uncomment the following if you intend to connect your internal services in Massdriver.
## You will also need to uncomment the corresponding artifacts in `massdriver.yaml`.
########

# locals {
#   # etc can contain any custom information you need to pass to downstream services.
#   # These values are _not_ type checked by Massdriver.
#   artifact_data_etc = {
#     anything_you_want = "true"
#   }

#   public_artifact_data = {
#     etc = local.artifact_data_etc
#     api = {
#       # The publicly accessible ingress hostname and path
#       hostname = var.ingress.enabled ? "${var.ingress.host}${var.ingress.path}" : ""
#       # By default this all traffic is redirected to HTTPS on port 443
#       port = 443
#       protocol = "https"
#     }
#   }

#   internal_artifact_data = {
#     etc = local.artifact_data_etc
#     api = {
#       # The internal kubernetes service discovery hostname
#       hostname = "${var.md_metadata.name_prefix}.${var.namespace}.svc.cluster.local"
#       # By default, the chart exposes the same container port at the service
#       port = var.port
#       # Internal cluster communication doesn't have TLS termination since it doesn't go through the ingress controller
#       protocol = "http"
#     }
#   }

#   artifact_specs = {
#     # An API version is required, you can set to 0.0.0 or "n/a" if you don't version your API.
#     api = {
#       version = "0.0.1"
#     }
#   }
# }

# resource "massdriver_artifact" "public" {
#   field                = "public"
#   provider_resource_id = "${var.md_metadata.name_prefix}-public-api"
#   name                 = "Public API endpoint for ${var.md_metadata.name_prefix}"
#   artifact             = jsonencode({
#     data = local.public_artifact_data
#     specs = local.artifact_specs
#   })
# }

# resource "massdriver_artifact" "internal" {
#   field                = "internal"
#   provider_resource_id = "${var.md_metadata.name_prefix}-internal-api"
#   name                 = "Kubernetes internal API endpoint for ${var.md_metadata.name_prefix}"
#   artifact             = jsonencode({
#     data = local.internal_artifact_data
#     specs = local.artifact_specs
#   })
# }
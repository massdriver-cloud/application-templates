#########
### Uncomment below to enable producing artifacts for your web service.
### You only need to uncomment the following if you intend to connect your internal services in Massdriver.
### You will also need to uncomment `api` under artifacts in `massdriver.yaml`.
#########

# locals {
#   api_data = {
#     # etc can contain any custom information you need to pass to downstream services.
#     # These values are _not_ type checked by Massdriver.
#     etc = {
#       anything_you_want = true
#     }

#     api = {
#       # The hostname for your API.
#       hostname = "your hostname here"
#       # The port your API listens on.
#       port = 443

#       # Layer 3 or layer 7 protocol is optional
#       # protocol = "tcp|https|udp"
#     }
#   }

#   api_specs = {
#     # An API version is required, you can set to 0.0.0 or "n/a" if you don't version your API.
#     version = "0.0.1"
#   }
# }

# resource "massdriver_artifact" "api" {
#   field                = "api"
#   provider_resource_id = "this will need to be custom to the app module {helm, ec2, etc} to the app identity"
#   name                 = "API: ${var.md_metadata.name_prefix}"
#   artifact             = jsonencode({
#     data = local.api_data
#     specs = local.api_specs
#   })
# }

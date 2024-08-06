# resource "massdriver_artifact" "<name>" {
#   field                = "the field in the artifacts schema"
#   provider_resource_id = "AWS ARN or K8S SelfLink"
#   name                 = "a contextual name for the artifact"
#   artifact = jsonencode(
#     {
#       # data = {
#       #   # This should match the aws-rds-arn.json schema file
#       #   arn = "aws::..."
#       # }
#       # specs = {
#       #   # Any existing spec in ./specs
#       #   # aws = {}
#       # }
#     }
#   )
# }

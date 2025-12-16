# resource "massdriver_artifact" "<name>" {
#   field                = "the field in the artifacts schema"
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

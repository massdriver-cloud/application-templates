# TODO: chart name comes from var.md_metadata.name_prefix
# TODO: feed env vars to helm chart from module.application.envs (and merge w/ param.envs if we want to keep this, im not a fan)
# TODO: make sure the 'host' field is actually just the subdomain, k8s will be handling the zone. Make this clear in the description
# TODO: I dont see any external-dns in the chart...
# TODO: add helm resource

module "application" {
  source = "github.com/massdriver-cloud/terraform-modules//massdriver-application"
  name   = var.md_metadata.name_prefix
  identity = {
    assume_role_policy = <<EOF
{
		"Version": "2012-10-17",
		"Statement": [
			{
				"Effect": "Allow",
				"Action": [
					"sts:AssumeRole"
				],
				"Principal": {
					"Service": [
						"ec2.amazonaws.com"
					]
				}
			}
		]
	}
   EOF
  }
}

# TODO: remove this artifact
resource "massdriver_artifact" "tmp" {
  field                = "tmp"
  provider_resource_id = "tmp:${timestamp()}"
  name                 = "Debugging output for guestbook app ${timestamp()}"
  artifact = jsonencode(
    {
      data = {
        vars = [
          { key = "policies", value = jsonencode(module.application.policies) },
          { key = "envs", value = jsonencode(module.application.envs) },
          { key = "cloud", value = module.application.cloud }
        ]
      }
      specs = {}
    }
  )
}


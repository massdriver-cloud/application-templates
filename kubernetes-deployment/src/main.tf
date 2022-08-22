# TODO: make sure the 'host' field is actually just the subdomain, k8s will be handling the zone. Make this clear in the description
# TODO: I dont see any external-dns in the chart...

module "application" {
  source = "github.com/massdriver-cloud/terraform-modules//massdriver-application"
  name   = var.md_metadata.name_prefix

  # TODO: this will need to be finagled per cloud type to get the right k8s bits.
  # This could be moved into the module w/ a simpler api here like
  # service = "ec2" | "lambda" | "k8s:the-data-in-some-consisten-way-that-the-module-can-parse"
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

module "application" {
  source  = "github.com/massdriver-cloud/terraform-modules//massdriver-application"
  name    = var.md_metadata.name_prefix
  service = "vm"
}

# TODO: Put aws ec2 vm tf code here

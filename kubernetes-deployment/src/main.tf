# TODO: make sure the 'host' field is actually just the subdomain, k8s will be handling the zone. Make this clear in the description
# TODO: I dont see any external-dns in the chart...

module "application" {
  source  = "github.com/massdriver-cloud/terraform-modules//massdriver-application"
  name    = var.md_metadata.name_prefix
  service = "kubernetes"
}

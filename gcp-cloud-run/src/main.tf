module "application" {
  source  = "github.com/massdriver-cloud/terraform-modules//massdriver-application?ref=c879d33"
  name    = var.md_metadata.name_prefix
  service = "function"
}

module "cloud_run" {
  source               = "./module"
  application_identity = module.application.id
  md_metadata          = var.md_metadata
  container_image      = "${var.container.repository}/${var.container.image}:${var.container.tag}"
  envs                 = module.application.envs
  endpoint             = var.endpoint
  location             = var.location
}

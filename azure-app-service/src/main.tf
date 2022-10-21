module "application_app_service" {
  source        = "github.com/massdriver-cloud/terraform-modules//massdriver-application-azure-app-service?ref=22d422e"
  name          = var.md_metadata.name_prefix
  application   = var.application
  image         = var.image
  dns           = var.dns
  contact_email = var.md_metadata.target.contact_email
  tags          = var.md_metadata.default_tags
}

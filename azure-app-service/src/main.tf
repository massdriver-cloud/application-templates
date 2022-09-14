module "application_app_service" {
  source      = "github.com/massdriver-cloud/terraform-modules//massdriver-application-azure-app-service?ref=edc2f7d"
  application = var.application
  image       = var.image
  dns         = var.dns
}

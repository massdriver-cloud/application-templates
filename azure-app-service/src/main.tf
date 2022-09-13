module "application_app_service" {
  source      = "github.com/massdriver-cloud/terraform-modules//massdriver-application-azure-app-service?ref=edc2f7d"
  application = var.application
  repo        = var.repo
  dns         = var.dns
}

module "application_app_service" {
  source = "github.com/massdriver-cloud/terraform-modules//massdriver-application-azure-app-service?ref="
  application {
    location             = var.application.location
    sku_name             = var.application.sku_name
    minimum_worker_count = var.application.minimum_worker_count
    maximum_worker_count = var.application.maximum_worker_count
    notification_email   = var.application.notification_email
  }
  repo {
    docker_image     = var.repo.docker_image
    docker_image_tag = var.repo.docker_image_tag
  }
  dns {
    enable_dns          = var.dns.enable_dns
    txt_record          = var.dns.txt_record
    cname_record        = var.dns.cname_record
    zone_name           = var.dns.zone_name
    zone_resource_group = var.dns.zone_resource_group
  }
}

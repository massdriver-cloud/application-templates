module "application_cloud_run" {
  source             = "github.com/massdriver-cloud/terraform-modules//massdriver-application-gcp-cloud-run?ref=96fa197"
  location           = var.location
  container_image    = "${var.container.repository}/${var.container.image}:${var.container.tag}"
  endpoint           = var.endpoint
  max_instances      = var.max_instances
  network            = var.gcp_global_network.data.grn
  vpc_connector_cidr = var.private_service_cidr
}

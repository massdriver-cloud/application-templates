module "application" {
  source               = "github.com/massdriver-cloud/terraform-modules//massdriver-application-gcp-vm?ref=779f770"
  location             = var.location
  container_image      = "${var.container.repository}/${var.container.image}:${var.container.tag}"
  compute_image_family = var.compute_image_family
  endpoint             = var.endpoint
  max_instances        = var.max_instances
  machine_type         = var.machine_type
  port                 = 80
  subnetwork           = var.subnetwork
  health_check = {
    port = 80
    path = "/"
  }
}

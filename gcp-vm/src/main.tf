module "application" {
  source          = "github.com/massdriver-cloud/terraform-modules//massdriver-application-gcp-vm?ref=5f3a359"
  location        = var.location
  container_image = "${var.container.repository}/${var.container.image}:${var.container.tag}"
  endpoint        = var.endpoint
  max_instances   = var.max_instances
  machine_type    = var.machine_type
  port            = 80
  subnetwork      = var.subnetwork
}


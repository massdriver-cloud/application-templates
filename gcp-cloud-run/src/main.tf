module "application_cloud_run" {
<<<<<<< HEAD
<<<<<<< HEAD
  source          = "github.com/massdriver-cloud/terraform-modules//massdriver-application-gcp-cloud-run?ref=2b0f322"
=======
  source          = "github.com/massdriver-cloud/terraform-modules//massdriver-application-gcp-cloud-run"
>>>>>>> 1548851 (Update gcp-cloud-run/src/main.tf)
  location        = var.location
  container_image = "${var.container.repository}/${var.container.image}:${var.container.tag}"
  endpoint        = var.endpoint
=======
  source             = "github.com/massdriver-cloud/terraform-modules//massdriver-application-gcp-cloud-run?ref=2b0f322"
  location           = var.location
  container_image    = "${var.container.repository}/${var.container.image}:${var.container.tag}"
  zone               = local.zone
  subdomain          = local.subdomain
  network            = var.gcp_global_network.data.grn
  vpc_connector_cidr = var.private_service_cidr
>>>>>>> 65274e2 (adding vars)
}

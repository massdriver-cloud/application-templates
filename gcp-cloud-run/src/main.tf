module "application_cloud_run" {
  source          = "github.com/massdriver-cloud/terraform-modules//massdriver-application-gcp-cloud-run?ref=2b0f322"
  location        = var.location
  container_image = "${var.container.repository}/${var.container.image}:${var.container.tag}"
  endpoint        = var.endpoint
}

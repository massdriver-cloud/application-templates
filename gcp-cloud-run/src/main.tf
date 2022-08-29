module "application_cloud_run" {
  source          = "github.com/massdriver-cloud/terraform-modules//gcp-application-cloud-run"
  location        = var.location
  container_image = "${var.container.repository}/${var.container.image}:${var.container.tag}"
  endpoint        = var.endpoint
}

module "application_cloud_run" {
  source                = "github.com/massdriver-cloud/terraform-modules//massdriver-application-gcp-cloud-run?ref=0346144"
  md_metadata           = var.md_metadata
  location              = local.gcp_region
  container_image       = "${var.container.repository}/${var.container.image}:${var.container.tag}"
  container_port        = 8080
  endpoint              = var.endpoint
  max_instances         = var.max_instances
  vpc_connector         = var.gcp_subnetwork.data.infrastructure.vpc_access_connector
  container_concurrency = var.container_concurrency
}

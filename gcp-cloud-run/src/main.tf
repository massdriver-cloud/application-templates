module "application_cloud_run" {
  source      = "github.com/massdriver-cloud/terraform-modules//massdriver-application-gcp-cloud-run?ref=abd42ad"
  md_metadata = var.md_metadata
  platform = {
    location      = local.gcp_region
    max_instances = var.platform.max_instances
  }
  container = {
    image = {
      repository = var.container.image.repository
      name       = var.container.image.name
      tag        = var.container.image.tag
    }
    port        = var.container.port
    concurrency = var.container.concurrency
  }
  endpoint              = var.endpoint
  vpc_connector         = var.gcp_subnetwork.data.infrastructure.vpc_access_connector
}

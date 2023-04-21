module "application" {
  source  = "github.com/massdriver-cloud/terraform-modules//massdriver-application?ref=735929b"
  name    = var.md_metadata.name_prefix
  service = "function"
}

module "apis" {
  source = "github.com/massdriver-cloud/terraform-modules//gcp-enable-apis?ref=735929b"
  services = [
    "cloudbuild.googleapis.com",
    "run.googleapis.com",
    "vpcaccess.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com"
  ]
}

resource "google_cloud_run_service" "main" {
  name     = var.md_metadata.name_prefix
  location = local.gcp_region

  template {
    metadata {
      annotations = {
        "run.googleapis.com/vpc-access-connector" = var.gcp_subnetwork.data.infrastructure.vpc_access_connector
        "run.googleapis.com/vpc-access-egress" = "all-traffic"
        "autoscaling.knative.dev/maxScale"     = "${var.platform.max_instances}"
      }
    }

    spec {
      service_account_name  = var.gcp_authentication.data.client_email
      container_concurrency = var.container.concurrency
      containers {
        image = "${var.container.image.repository}:${var.container.image.tag}"
        ports {
          container_port = var.container.port
        }
        dynamic "env" {
          for_each = module.application.envs
          content {
            name  = env.key
            value = env.value
          }
        }
      }
    }
  }
  metadata {
    annotations = {
      # For valid annotation values and descriptions, see
      # https://cloud.google.com/sdk/gcloud/reference/run/deploy#--ingress
      "run.googleapis.com/ingress" = "all"
    }
  }

  depends_on = [
    module.apis
  ]
}

resource "null_resource" "sleep" {
  triggers = {
    sleep_time = 30
  }
  provisioner "local-exec" {
    command = "sleep 30"
  }

  depends_on = [google_cloud_run_service.main]
}

resource "google_cloud_run_service_iam_binding" "main" {
  location = local.gcp_region
  service  = var.md_metadata.name_prefix
  role     = "roles/run.invoker"
  members = [
    "allUsers"
  ]
  depends_on = [null_resource.sleep]
}
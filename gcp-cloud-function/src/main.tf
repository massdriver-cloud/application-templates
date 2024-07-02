locals {
  entrypoint_map = {
    # This map helps set the initial entrypoint for a cloud function deploying with the Hello World code
    "python"  = "hello_http"
    "node"    = "helloHttp"
    "php"     = "helloHttp"
    "ruby"    = "hello_http"
    "go"      = "HelloHTTP"
    "java11"  = "gcfv2.HelloHttpFunction"
    "java17"  = "gcfv2.HelloHttpFunction"
    "java21"  = "gcfv2.HelloHttpFunction"
    "dotnet8" = "HelloHttp.Function"
    "dotnet6" = "HelloHttp.Function"
    "dotnet3" = "HelloHttp.Function"
  }
  runtime_map = {
    # This map helps locate the correct runtime directory for the Hello World cloud function source code
    "nodejs20"  = "node"
    "nodejs18"  = "node"
    "nodejs16"  = "node"
    "nodejs14"  = "node"
    "nodejs12"  = "node"
    "ruby32"    = "ruby"
    "ruby30"    = "ruby"
    "ruby27"    = "ruby"
    "ruby26"    = "ruby"
    "python312" = "python"
    "python311" = "python"
    "python310" = "python"
    "python39"  = "python"
    "python38"  = "python"
    "php83"     = "php"
    "php82"     = "php"
    "php81"     = "php"
    "php74"     = "php"
    "java21"    = "java21"
    "java17"    = "java17"
    "java11"    = "java11"
    "go122"     = "go"
    "go121"     = "go"
    "go120"     = "go"
    "go119"     = "go"
    "go118"     = "go"
    "go116"     = "go"
    "go113"     = "go"
    "dotnet8"   = "dotnet8"
    "dotnet6"   = "dotnet6"
    "dotnet3"   = "dotnet3"
  }
}

module "application" {
  source  = "github.com/massdriver-cloud/terraform-modules//massdriver-application?ref=a1b2019"
  name    = var.md_metadata.name_prefix
  service = "function"
}

resource "google_cloudfunctions_function" "main" {
  name                          = var.md_metadata.name_prefix
  service_account_email         = module.application.identity
  labels                        = var.md_metadata.default_tags
  region                        = local.gcp_region
  runtime                       = var.cloud_function_configuration.runtime
  environment_variables         = module.application.envs
  trigger_http                  = true
  entry_point                   = var.cloud_function_configuration.entrypoint == "HelloWorld" ? local.entrypoint_map[local.runtime_map[var.cloud_function_configuration.runtime]] : var.cloud_function_configuration.entrypoint
  available_memory_mb           = var.cloud_function_configuration.memory_mb
  min_instances                 = var.cloud_function_configuration.minimum_instances
  max_instances                 = var.cloud_function_configuration.maximum_instances
  source_archive_bucket         = google_storage_bucket.main.name
  source_archive_object         = var.source_archive_path
  ingress_settings              = "ALLOW_INTERNAL_AND_GCLB"
  vpc_connector                 = var.gcp_subnetwork.data.infrastructure.vpc_access_connector
  vpc_connector_egress_settings = "PRIVATE_RANGES_ONLY"

  # default: 60  (s)
  # max    : 540 (s)
  timeout = 120

  depends_on = [
    module.apis
  ]
}

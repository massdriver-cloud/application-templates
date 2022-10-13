# TODO: prompt for these in the CLI
# https://cloud.google.com/functions/docs/concepts/execution-environment
# runtime:
#   type: string
#   title: Runtime
#   oneOf:
#   - title: Node.js 16
#     const: nodejs16
#   - title: Node.js 14
#     const: nodejs14
#   - title: Python 3.10
#     const: python310
#   - title: Python 3.9
#     const: python39
#   - title: Python 3.8
#     const: python38
#   - title: Go 1.16
#     const: go116
#   - title: Go 1.13
#     const: go113
#   - title: Java 17
#     const: java17
#   - title: Java 11
#     const: java11
#   - title: .NET Core 6.0
#     const: dotnet6
#   - title: .NET Core 3.1
#     const: dotnet3
#   - title: Ruby 3.0
#     const: ruby30
#   - title: Ruby 2.7
#     const: ruby27
#   - title: PHP 8.1
#     const: php81
#   - title: PHP 7.4
#     const: php74

module "app" {
  source              = "../../../terraform-modules/massdriver-application-gcp-cloud-function"
  md_metadata         = var.md_metadata
  location            = var.gcp_subnetwork.specs.gcp.region
  source_archive_path = var.source_archive_path
  cloud_function_configuration = merge(var.cloud_function_configuration, {
    runtime = "python310"
  })
  endpoint      = var.endpoint
  vpc_connector = var.gcp_subnetwork.data.infrastructure.vpc_access_connector
}

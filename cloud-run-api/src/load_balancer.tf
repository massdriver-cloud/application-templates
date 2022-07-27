# TODO: enable when you have a verified dns zone

# resource "google_compute_global_address" "main" {
#   name         = var.md_metadata.name_prefix
#   ip_version   = "IPV4"
#   address_type = "EXTERNAL"
# }

# resource "google_compute_managed_ssl_certificate" "main" {
#   name = var.md_metadata.name_prefix

#   managed {
#     domains = [local.domain]
#   }
# }

# resource "google_compute_target_https_proxy" "main" {
#   name             = var.md_metadata.name_prefix
#   url_map          = google_compute_url_map.main.self_link
#   ssl_certificates = [google_compute_managed_ssl_certificate.main.id]
# }

# resource "google_compute_global_forwarding_rule" "main" {
#   provider   = google-beta
#   name       = var.md_metadata.name_prefix
#   labels     = var.md_metadata.default_tags
#   target     = google_compute_target_https_proxy.main.self_link
#   ip_address = google_compute_global_address.main.address
#   port_range = "443"
#   depends_on = [google_compute_global_address.main]
# }

# # missing piece to cloud run DNS!
# resource "google_compute_region_network_endpoint_group" "main" {
#   name                  = var.md_metadata.name_prefix
#   network_endpoint_type = "SERVERLESS"
#   region                = local.gcp_region
#   cloud_run {
#     service = google_cloud_run_service.main.name
#   }
# }

# resource "google_compute_backend_service" "main" {
#   name        = var.md_metadata.name_prefix
#   timeout_sec = 30

#   backend {
#     group = google_compute_region_network_endpoint_group.main.id
#   }
# }

# resource "google_compute_url_map" "main" {
#   name            = var.md_metadata.name_prefix
#   default_service = google_compute_backend_service.main.id

#   host_rule {
#     hosts        = ["*"]
#     path_matcher = "all"
#   }

#   path_matcher {
#     name            = "all"
#     default_service = google_compute_backend_service.main.id
#   }
# }

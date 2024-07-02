resource "google_compute_global_address" "main" {
  name         = var.md_metadata.name_prefix
  ip_version   = "IPV4"
  address_type = "EXTERNAL"
}

resource "google_compute_managed_ssl_certificate" "main" {
  name = var.md_metadata.name_prefix

  managed {
    domains = ["${var.endpoint.subdomain}.${data.google_dns_managed_zone.main.dns_name}"]
  }
}

resource "google_compute_target_https_proxy" "main" {
  name             = var.md_metadata.name_prefix
  url_map          = google_compute_url_map.main.self_link
  ssl_certificates = [google_compute_managed_ssl_certificate.main.id]
}

resource "google_compute_target_http_proxy" "main" {
  name    = var.md_metadata.name_prefix
  url_map = google_compute_url_map.https_redirect.self_link
}

resource "google_compute_global_forwarding_rule" "http" {
  provider   = google-beta
  name       = var.md_metadata.name_prefix
  labels     = var.md_metadata.default_tags
  target     = google_compute_target_http_proxy.main.self_link
  ip_address = google_compute_global_address.main.address
  port_range = "80"
  depends_on = [google_compute_global_address.main]
}

resource "google_compute_global_forwarding_rule" "https" {
  provider   = google-beta
  name       = "${var.md_metadata.name_prefix}-https"
  labels     = var.md_metadata.default_tags
  target     = google_compute_target_https_proxy.main.self_link
  ip_address = google_compute_global_address.main.address
  port_range = "443"
  depends_on = [google_compute_global_address.main]
}

resource "google_compute_url_map" "main" {
  name            = "${var.md_metadata.name_prefix}-https"
  default_service = google_compute_backend_service.main[0].id

  host_rule {
    hosts        = ["*"]
    path_matcher = "all"
  }

  path_matcher {
    name            = "all"
    default_service = google_compute_backend_service.main[0].id
  }
}

resource "google_compute_url_map" "https_redirect" {
  name = "${var.md_metadata.name_prefix}-redirect"
  default_url_redirect {
    https_redirect         = true
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
    strip_query            = false
  }
}

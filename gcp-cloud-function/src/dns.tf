locals {
  managed_zone_name = length(split("/", var.endpoint.zone.name)) > 1 ? split("/", var.endpoint.zone.name)[3] : var.endpoint.zone.name
  dns_record_name   = "${var.endpoint.subdomain}.${data.google_dns_managed_zone.main.dns_name}"
  endpoint          = substr(local.dns_record_name, 0, length(local.dns_record_name) - 1)
}

data "google_dns_managed_zone" "main" {
  name  = local.managed_zone_name
}

resource "google_dns_record_set" "main" {
  name         = local.dns_record_name
  type         = "A"
  ttl          = 3600
  managed_zone = data.google_dns_managed_zone.main.name
  rrdatas      = [google_compute_global_forwarding_rule.https.ip_address]
}

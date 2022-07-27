locals {
  domain   = "${var.subdomain}.${data.google_dns_managed_zone.main.dns_name}"
  full_url = "https://${local.domain}"
}

data "google_dns_managed_zone" "main" {
  name = var.cloud_dns_managed_zone.name
  depends_on = [
    module.apis
  ]
}

# resource "google_dns_record_set" "set" {
#   name         = local.domain
#   type         = "A"
#   ttl          = 3600
#   managed_zone = data.google_dns_managed_zone.main.name
#   rrdatas      = [google_compute_global_forwarding_rule.main.ip_address]
# }

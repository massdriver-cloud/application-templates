locals {
  services = [
    "cloudbuild.googleapis.com",
    "cloudfunctions.googleapis.com"
  ]
}

resource "google_project_service" "main" {
  for_each = toset(local.services)
  service  = each.value

  disable_dependent_services = false
  disable_on_destroy         = false
}

resource "null_resource" "waiter" {
  triggers = {
    sleep_time = 30
    services   = join(",", local.services)
  }
  provisioner "local-exec" {
    command = "sleep 30"
  }

  depends_on = [google_project_service.main]
}

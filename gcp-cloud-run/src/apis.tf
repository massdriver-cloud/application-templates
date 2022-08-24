module "apis" {
  source = "github.com/massdriver-cloud/terraform-modules//google-enable-apis?ref=9201b9f"
  services = [
    "cloudbuild.googleapis.com",
    "run.googleapis.com"
  ]
}

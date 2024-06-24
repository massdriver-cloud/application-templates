module "apis" {
  source = "github.com/massdriver-cloud/terraform-modules//gcp-enable-apis?ref=a1b2019"
  services = [
    "cloudbuild.googleapis.com",
    "run.googleapis.com",
    "vpcaccess.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com"
  ]
}

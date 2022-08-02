<md if (eq .CloudProvider "aws") md>
module "k8s_application" {
  source = "massdriver......./..../k8s-application-aws?ref=TODO"
}
<md end md>

<md if (eq .CloudProvider "azure") md>
module "k8s_application" {
  source = "massdriver......./..../k8s-application-azure?ref=TODO"
}
<md end md>

<md if (eq .CloudProvider "gcp") md>
module "k8s_application" {
  source = "github.com/massdriver-cloud/terraform-modules//k8s-application-gcp?ref=TODO"
}
<md end md>

# <md .Name md>

<md .Description md>

## Massdriver `gcp-cloud-run` Template

The `gcp-cloud-run` template will run your application on GCP's Cloud Run.

**Files**:

- a [terraform module](./src) is included that configurings IAM permissions and sets up you environment variables. You likely _do not_ need to modify these files. This module is simply rigging code to integrate with Massdriver Cloud.
- the [`massdriver.yaml`](./massdriver.yaml) controls the UI to expose for configuring your application and its dependencies. By default there are a lot of fields in your [`params`](https://docs.massdriver.cloud/bundles/configuration#bundle-params) section, feel free to remove fields that you do not want exposed in your configuration form in Massdriver Cloud. Values that you do not want to change (e.g.: your image repository) can be hard coded in the [main.tf](./src/main.tf) file.

# {{ name }} :: Rails on Kubernetes

{{ description }}

## Massdriver `rails-kubernetes` Template

This application template is built using the [Ruby on Rails Helm Chart](https://artifacthub.io/packages/helm/massdriver/ruby-on-rails).

An example application using this template can be found [here](https://github.com/massdriver-cloud/application-examples/tree/main/k8s/rails-spree).

The `rails-kubernetes` template will run your Rails application on Kubernetes. This template supports AWS EKS, GCP GKE, Azure AKS, bare metal Kubernetes and managed Kubernetes.

### Files

**[`massdriver.yaml`](./massdriver.yaml)**

This file controls the UI to expose for configuring your application and its dependencies. By default there are a lot of fields in your [`params`](https://docs.massdriver.cloud/bundles/configuration#bundle-params) section, feel free to remove fields that you do not want exposed in your configuration form in Massdriver Cloud. Values that you do not want to change (e.g.: your image repository) can be hard coded in the [values.yaml](./src/chart/values.yaml) file.

**[terraform module](./src)**

`src` contains a terraform module that handles integration with Massdriver Cloud.

This parses `massdriver.yaml` to determine IAM policies to bind, environment variables to set, and secrets to fetch from our secret store. This module also creates a _"role"_ for your application in your cloud to bind any IAM policies to.

We **do not** recommend modifying this file.


## Notes

* `image` is included in the `massdriver.yaml` for convenience. We recommend hard coding this in `values.yaml` if your container image doesn't change from deployment to deployment.
* Rails migrations are implemented as kubernetes jobs using the _Helm Release_ as a suffix and run on each apply. Since the old and new version of your application is running, backwards compatible migrations are recommendedl

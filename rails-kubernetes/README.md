# <md .Name md>

<md .Description md>

An example application using this template can be found [here](https://github.com/massdriver-cloud/application-examples/tree/main/k8s/rails-spree).

## Massdriver `rails-kubernetes` Template

The `rails-kubernetes` template will run your Rails application on Kubernets. Supports AWS EKS, GCP GKE, or Azure AKS, bare metal Kubernetes or managed Kubernetes.

**Files**:

* [`massdriver.yaml`](./massdriver.yaml) controls the UI to expose for configuring your application and its dependencies. By default there are a lot of fields in your [`params`](https://docs.massdriver.cloud/bundles/configuration#bundle-params) section, feel free to remove fields that you do not want exposed in your configuration form in Massdriver Cloud. Values that you do not want to change (e.g.: your image repository) can be hard coded in the [values.yaml](./src/chart/values.yaml) file.


* [helm chart](./src/chart) has been created to run a kubernetes deployment. This Helm chart is a great getting started point for deploying to Kubernetes. Feel free to modify the chart to customize your application deployment.

  * great place to set constants that you dont want to expose through `params`.

* [terraform module](./src) handles integrations with Massdriver Cloud. Parses `massdriver.yaml`. Create IAM application identity through your clouds k8s implementation, binds IAM policies...

## Notes:

* image ... would recommend hard coding or using the drop down
* migrations as helm hooks, backwards compat migrations

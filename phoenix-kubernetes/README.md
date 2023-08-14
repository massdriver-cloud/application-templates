# {{ name }} :: Elixir/Phoenix Kubernetes

{{ description }}

## Massdriver `phoenix-kubernetes` Template

This application template is built using the [Elixir/Phoenix Helm Chart](https://artifacthub.io/packages/helm/massdriver/elixir-phoenix).

An example application using this template can be found [here](https://github.com/massdriver-cloud/application-examples/tree/main/k8s/phoenix-chat-example).

The `phoenix-kubernetes` template will run your Phoenix application on Kubernetes. This template supports AWS EKS, GCP GKE, Azure AKS, bare metal Kubernetes and managed Kubernetes.

### Files

**[`massdriver.yaml`](./massdriver.yaml)**

This file controls the UI to expose for configuring your application and its dependencies. By default there are a lot of fields in your [`params`](https://docs.massdriver.cloud/bundles/configuration#bundle-params) section, feel free to remove fields that you do not want exposed in your configuration form in Massdriver Cloud. Values that you do not want to change (e.g.: your image repository) can be hard coded in the [values.yaml](./src/chart/values.yaml) file.

**[terraform module](./src)**

`src` contains a terraform module that handles integration with Massdriver Cloud.

This parses `massdriver.yaml` to determine IAM policies to bind, environment variables to set, and secrets to fetch from our secret store. This module also creates a _"role"_ for your application in your cloud to bind any IAM policies to.

We **do not** recommend modifying this file.


## Notes

* `image` is included in the `massdriver.yaml` for convenience. We recommend hard coding this in `values.yaml` if your container image doesn't change from deployment to deployment.
* Ecto migrations are implemented as kubernetes jobs using the _Helm Release_ as a suffix and run on each apply. Since the old and new version of your application is running, backwards compatible migrations are recommended.

## Next Steps

### Dockerfile

If you don't yet have a Dockerfile for your phoenix application, then phoenix can [generate one for you](https://hexdocs.pm/phoenix/Mix.Tasks.Phx.Gen.Release.html). Run

```
mix phx.gen.release --docker
```

from your project's root folder to create a best-practices Dockerfile which you can use to build an image to deploy using Massdriver.

### GitHub Workflows

Once your application is deployed with Massdriver, you can use a simple GitHub Workflow to implement Continuous Deployment for your application.

From this folder, run

```
wget --output-document=deploy.yml --directory-prefix=.github/workflows https://github.com/massdriver-cloud/actions/blob/main/example-workflow.yaml
```

and [fill in the required env vars](https://github.com/massdriver-cloud/actions#quick-setup) to deploy your application on every push to `main`.

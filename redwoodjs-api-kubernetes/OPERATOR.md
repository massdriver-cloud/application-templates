# RedwoodJS API

## Shelling into your App

You'll need to download the Kubernetes credential from your cluster:

![Download Credential](https://raw.githubusercontent.com/massdriver-cloud/aws-eks-cluster/fdcc6476fe99976b934d45bf5281880f56a2fa2b/images/kubeconfig-download.gif)

```shell
export MD_PACKAGE_NAME=YOUR_NAME
kubectl exec $(kubectl get pod -l md-package=${MD_PACKAGE_NAME} -o jsonpath="{.items[0].metadata.name}") -it -- /bin/bash
```

## Seeding Your Database

**Note: During beta migrations are hard coded to be turned on in RedwoodJS API deployments in `src/main.tf`.**


Your database should have been created on your first deployment, and on subsequent deployments will automatically migrate.

If you need to run a seed job, you can do so:

```shell
kubectl get secrets --field-selector type=kubernetes.io/tls --kubeconfig=/path/to/your/downloaded/config.yaml
```

There may be more than one result, it should be start with your `MD_PACKAGE_NAME`.

```shell
kubectl get secrets --field-selector type=kubernetes.io/tls --kubeconfig=/tmp/kubeconfig.yaml
kubectl run oneoff -i --rm --overrides='
{
  "spec": {
    "containers": [
      {
        "command": ["bash", "-c"],
        "args": ["yarn rw prisma generate && yarn rw exec seed"],
        "name": "seed",
        "image": "YOUR_MIGRATION_CONTAINER_IMAGE_NAME_HERE",
        "envFrom": [
          {
            "secretRef": {
              "name": "YOUR_SECRET_FROM_ABOVE_HERE"
            }
          }
        ]
      }
    ]
  }
}
'  --image=YOUR_MIGRATION_CONTAINER_IMAGE_NAME_HERE --kubeconfig=/path/to/your/downloaded/config.yaml

```

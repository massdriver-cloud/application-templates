# <md .Name md> Guide

<md .Description md>

---

An example guide / runbook for running '<md .Name md>'.

This guide will appear under *Guides** on your Massdriver canvas.

---

### Links

* [Rails Kubernetes Application Template](https://github.com/massdriver-cloud/application-templates/tree/main/rails-kubernetes)
* [Example Spree App](https://github.com/massdriver-cloud/application-examples/tree/main/k8s/rails-spree)

### "SSHing"

```shell
export MD_PACKAGE_NAME=YOUR_NAME
kubectl exec $(kubectl get pod -l md-package=${MD_PACKAGE_NAME} -o jsonpath="{.items[0].metadata.name}") -it -- /bin/bash
```

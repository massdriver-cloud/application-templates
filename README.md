# application-templates

Application templates for quickly rendering applications to run on massdriver provisioned cloud infrastructure.

## Development

The [`mass`](https://github.com/massdriver-cloud/massdriver-cli/) CLI has a development flag that can be set to render templates from a local git directory instead of from the main git repo.

```shell
MD_DEV_TEMPLATES_PATH="~/work/application-templates" mass app new
```

To use alpha or beta templates during development:

```shell
MD_DEV_TEMPLATES_PATH="~/work/application-templates/alpha" mass app new
```

# application-templates

Application templates for running applications [Massdriver](https://massdriver.cloud) provisioned cloud infrastructure.

## Development

The [`mass`](https://github.com/massdriver-cloud/massdriver-cli/) CLI has a development flag that can be set to render templates from a local git directory instead of from the main git repo.

```shell
MD_DEV_TEMPLATES_PATH="~/work/application-templates" mass bundle new
```

To use custom templates during generation:

```shell
MD_DEV_TEMPLATES_PATH="~/work/path/to/your/application-templates" mass bundle new
```

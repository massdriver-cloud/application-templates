locals {
  helm_values = {
    # # The default command, args, and migration settings are below. Any
    # # values in values.yaml can be overwritten by adding a parameter to your massdriver.yaml
    # # or by hard coding the value here
    #     command = ["yarn"]
    #     args    = ["foo"]
    args = [
      "node_modules/.bin/rw-server", "web", "--apiHost", "https://${var.blog_api.data.api.hostname}"
    ]
    migration = {
      enabled = false
    }
  }
}

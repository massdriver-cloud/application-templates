locals {
  helm_values = {
    # # The default command, args, and migration settings are below. Any
    # # values in values.yaml can be overwritten by adding a parameter to your massdriver.yaml
    # # or by hard coding the value here
    # command = ["mix"]
    # args    = ["phx.server"]

    # migration = {
    #   enabled = true
    #   command = ["mix"]
    #   args    = ["do", "ecto.create,", "ecto.migrate"]
    # }

  }
}

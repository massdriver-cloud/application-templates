locals {
  helm_values = {
    # # The default command, args, and migration settings are below. Any
    # # values in values.yaml can be overwritten by adding a parameter to your massdriver.yaml
    # # or by hard coding the value here
    #     command = ["bundle"]
    #     args    = ["exec", "rails", "server"]
    #     migration = {

    #       enabled = true
    #       command = ["bash", "-c"]
    #       args = [<<ARGS
    # bundle exec rails db:create;
    # bundle exec rails db:migrate;
    # ARGS
    #       ]
    #     }

  }
}

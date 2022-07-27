# NOTE: this is a temporary file, this will be baked into the cli down the road.
.PHONY: plan

plan: ## Plans all examples
	mass app build
	ruby ./tf_helper.rb plan | bash

apply: ## Applies all examples
	mass app build
	ruby ./tf_helper.rb apply | bash

destroy: ## Destroys all examples
	mass app build
	ruby ./tf_helper.rb destroy | bash

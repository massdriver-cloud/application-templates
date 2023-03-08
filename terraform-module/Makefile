SHELL:=/bin/bash
TAG=release-$(shell date +%s)
# NOTE: this is a temporary file, this will be baked into the cli down the road.
.PHONY: plan

plan: ## Plans all examples
	mass bundle build
	ruby ./tf_helper.rb plan | bash

apply: ## Applies all examples
	mass bundle build
	ruby ./tf_helper.rb apply | bash

destroy: ## Destroys all examples
	mass bundle build
	ruby ./tf_helper.rb destroy | bash

.PHONY: release
release:
	@if ! command -v gh  &> /dev/null; then echo "please install gh cli https://github.com/cli/cli#installation" && exit 1; fi
	@if [ "$(git rev-parse HEAD)" != "$(git rev-parse origin/main)" ]; then echo "releasing is only supported from tip of origin/main currently: $(git rev-parse origin/main). Please git checkout main && git reset --hard origin/main and try again." && exit 1; fi
	gh release create ${TAG} --generate-notes --draft

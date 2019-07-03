export SHELL := /bin/bash

.DEFAULT_GOAL := help

# Common targets
# --------------
up: ## start sweetcount app
	@docker-compose -f docker-compose.yml up -d --remove-orphans

logs: ## tail sweetcount app logs
	@docker-compose -f docker-compose.yml logs -f

test: ## run newman
	@docker-compose -f docker-compose.yml -f docker-compose.tests.yml up --exit-code-from newman

cst: ## run Google Container Structure Tests
	@scripts/run-google-container-structure-tests.sh

# PHONY (non-file) Targets
# ------------------------
.PHONY: up logs test cst help

# `make help` -  see http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
# ------------------------------------------------------------------------------------
help: ## show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

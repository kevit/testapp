requirements: ## Install requirements from scratch
	pip install --user testinfra
	ansible-galaxy install -r requirements.yml -p roles --ignore-errors --force

create: ## Create an inventory for new environment
	mkdir -p inventories/$(name)/group_vars/all
	ln -s ../../../000_crossenv_vars 000_crossenv_vars

help: ## Show help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

test: ## Run tests
	py.test -v --connection=ansible --ansible-inventory=inventories/$(name)/hosts.ini tests/app.py

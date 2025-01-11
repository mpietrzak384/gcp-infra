ENV_FILE=.env

.PHONY: all
all: tools

.PHONY: tools
tools:
	@echo "Installing Checkov..."
	pip install checkov

.PHONY: lint
lint:
	@echo "Running Checkov linting..."
	checkov -d terraform

.PHONY: validate
validate:
	@echo "Validating Terraform configuration..."
	terraform validate

.PHONY: plan
plan:
	@echo "Running Terraform plan..."
	. $(ENV_FILE) && terraform plan

.PHONY: apply
apply:
	@echo "Applying Terraform configuration..."
	. $(ENV_FILE) && terraform apply -auto-approve

.PHONY: help
help:
	@echo "Available commands:"
	@echo "  make tools    - Install required tools (Checkov)"
	@echo "  make lint     - Run Checkov linting"
	@echo "  make plan     - Run 'terraform plan' (sources .env)"
	@echo "  make validate - Run 'terraform validate' (sources .env)"
	@echo "  make apply    - Run 'terraform apply' (sources .env)"
# include .env

help:##............Show this help
	@echo ""
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//' | sed 's/^/    /'
	@echo ""

.PHONY: init-cluster
init-cluster:##........Initialize terraform
	cd terraform/cluster && terraform init

.PHONY: init-services
init-services:##........Initialize terraform
	cd terraform/services && terraform init

.PHONY: init-upgrade-cluster
init-upgrade-cluster:## upgrade terraform with the latest providers
	cd terraform/cluster && terraform init -upgrade

.PHONY: init-upgrade-services
init-upgrade-services:## upgrade terraform with the latest providers
	cd terraform/services && terraform init -upgrade

.PHONY: plan-cluster
plan-cluster:##........Create an execution plan for terraform
	cd terraform/cluster && terraform plan

.PHONY: plan-services
plan-services:##........Create an execution plan for terraform
	cd terraform/services && terraform plan

.PHONY: apply-cluster
apply-cluster:##........Execute a terraform plan
	cd terraform/cluster && terraform apply --auto-approve

.PHONY: apply-services
apply-services:##........Execute a terraform plan
	cd terraform/services && terraform apply --auto-approve

.PHONY: format
format:##........Format both terraform and nomd job files
	cd terraform/cluster && terraform fmt -recursive -write
	cd terraform/services && terraform fmt -recursive -write
	cd terraform/nomad/jobs && nomad fmt -recursive -write

.PHONY: validate-jobs
validate-jobs:##........Validate all nomad jobs for correctness
	./terraform/scripts/validate-jobs.sh

.PHONY: build-%
build-%:##........Build and image with packer
	cd packer/$* && packer build -var-file=../packer.pkrvars.hcl .

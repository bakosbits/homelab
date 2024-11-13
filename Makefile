# include .env

help:##............Show this help
	@echo ""
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//' | sed 's/^/    /'
	@echo ""

.PHONY: init
init:##........Initialize terraform
	cd terraform && terraform init

.PHONY: init-upgrade
init-upgrade:## upgrade terraform with the latest providers
	cd terraform && terraform init -upgrade

.PHONY: plan
plan:##........Create an execution plan for terraform
	cd terraform && terraform plan

.PHONY: apply
apply:##........Execute a terraform plan
	cd terraform && terraform apply --parallelism=1 --auto-approve

.PHONY: apply-%
apply-%:##........Execute a module within a terraform plan
	cd terraform && terraform apply -target=module.$* --auto-approve	

.PHONY: format
format:##........Format both terraform and nomd job files
	cd terraform && terraform fmt -recursive -write
	cd terraform/nomad/jobs && nomad fmt -recursive -write

.PHONY: validate-jobs
validate-jobs:##........Validate all nomad jobs for correctness
	./terraform/scripts/validate-jobs.sh

.PHONY: build-%
build-%:##........Build and image with packer
	cd packer/$* && packer build -var-file=../vars/packer.pkrvars.hcl .

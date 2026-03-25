IMAGE ?= ghcr.io/syntasso/promise-postgresql/postgresql-configure-pipeline
TAG   ?= v0.4.0
KIND_CLUSTER ?= platform

.PHONY: help build clean load pull push

help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2}'

build: ## Build the Docker image
	docker build -t $(IMAGE):$(TAG) .

clean: ## Remove the Docker image from the local machine
	docker rmi $(IMAGE):$(TAG)

load: build ## Load the Docker image into the kind cluster
	kind load docker-image $(IMAGE):$(TAG) --name $(KIND_CLUSTER)

pull: ## Pull the Docker image from the registry
	docker pull $(IMAGE):$(TAG)

push: ## Push the Docker image
	docker push $(IMAGE):$(TAG)

test-promise: ## Test the promise deployment
	./scripts/test promise

test-resource-request: ## Test the resource request deployment
	./scripts/test resource-request
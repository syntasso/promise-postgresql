IMAGE ?= ghcr.io/syntasso/promise-postgresql/postgresql-configure-pipeline
TAG   ?= v0.4.0
KIND_CLUSTER ?= platform

BUILD_FLAGS := -t $(IMAGE):$(TAG)
ifdef CI
BUILD_FLAGS += --cache-from type=gha --cache-to type=gha,mode=max
endif

REPO_ROOT      ?= $(shell git rev-parse --show-toplevel)
WORKER_CONTEXT ?= kind-worker

.PHONY: help build clean load pull push test

help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2}'

build: ## Build the Docker image
	docker buildx build $(BUILD_FLAGS) --load .

clean: ## Remove the Docker image from the local machine
	docker rmi $(IMAGE):$(TAG)

load: build ## Load the Docker image into the kind cluster
	kind load docker-image $(IMAGE):$(TAG) --name $(KIND_CLUSTER)

pull: ## Pull the Docker image from the registry
	docker pull $(IMAGE):$(TAG)

push: ## Push the Docker image
	docker push $(IMAGE):$(TAG)

test: ## Run Ginkgo system tests
	WORKER_CONTEXT=$(WORKER_CONTEXT) \
	PROMISE_YAML=$(REPO_ROOT)/promise.yaml \
	RESOURCE_REQUEST_YAML=$(REPO_ROOT)/resource-request.yaml \
	go test -v ./test/... -timeout 10m
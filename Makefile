WORKFLOW_DIR  := workflows/configure-pipeline
WORKER_CONTEXT ?= kind-worker
RESOURCE_REQUEST_NAMESPACE ?= default
RENDERED_RESOURCE_NAME ?= acme-org-team-a-example-postgresql
WAIT_TIMEOUT ?= 60s

.PHONY: help \
        build-workflow load-workflow test test-workflow

help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-30s\033[0m %s\n", $$1, $$2}'

build-workflow: ## Build workflow pipeline image
	$(MAKE) -C $(WORKFLOW_DIR) build

load-workflow: ## Build and load the workflow pipeline image into kind
	$(MAKE) -C $(WORKFLOW_DIR) load

test: test-workflow ## Run all tests

test-workflow: ## Test the promise in a local kind cluster
	kubectl apply -f promise.yaml
	kubectl wait --for=create --timeout=$(WAIT_TIMEOUT) crd/postgresqls.marketplace.kratix.io
	kubectl wait --for=condition=Established --timeout=$(WAIT_TIMEOUT) crd/postgresqls.marketplace.kratix.io
	kubectl --context=$(WORKER_CONTEXT) wait --for=create --timeout=$(WAIT_TIMEOUT) crd/postgresqls.acid.zalan.do
	kubectl --context=$(WORKER_CONTEXT) wait --for=condition=Established --timeout=$(WAIT_TIMEOUT) crd/postgresqls.acid.zalan.do
	$(MAKE) -C $(WORKFLOW_DIR) test-promise
	kubectl apply -f resource-request.yaml
	kubectl --context=$(WORKER_CONTEXT) --namespace=$(RESOURCE_REQUEST_NAMESPACE) wait --for=create --timeout=$(WAIT_TIMEOUT) postgresqls.acid.zalan.do/$(RENDERED_RESOURCE_NAME)
	$(MAKE) -C $(WORKFLOW_DIR) test-resource-request

# Development

## Dependencies

In this Promise we bundle the Zalando Operator CRDs and a reference manifest
used to source defaults for the CRDs rendered by the Promise code.

We provide some convenience scripts to update these files:

```shell
# Fetch dependencies
./scripts/fetch-deps
# Fetch reference manifests
./scripts/fetch-pipeline-resources
```

## Pipeline image

To build the image:
```shell
make build
```

To load the image to the local kind platform cluster:

```shell
make load
```

To push the image to ghcr.io:

```shell
make push
```

## Testing

To test the promise install Kratix, and then:

```shell
kubectl apply -f ../promise.yaml
make test-promise
```

This asserts the Promise is installed correctly.

To test the resource request:

```shell
kubectl apply -f ../resource-request.yaml
make test-resource-request
```

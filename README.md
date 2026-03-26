# PostgreSQL

This Promise provides PostgreSQL-as-a-Service. The Promise has four fields:

* `.spec.env`
* `.spec.teamId`
* `.spec.dbName`
* `.spec.backupEnabled`

Check the CRD documentation for more information.


To install:
```
kubectl apply -f https://raw.githubusercontent.com/syntasso/promise-postgresql/main/promise.yaml
```

To make a resource request (small by default):
```
kubectl apply -f https://raw.githubusercontent.com/syntasso/promise-postgresql/main/resource-request.yaml
```

## Development

For development see [README.md](./workflows/configure-pipeline/README.md)

## Releasing

1. Update `promise-release.yaml` with the new version tag and URL, then commit directly to main or merge a PR:
   ```yaml
   spec:
     version: vX.Y.Z
     sourceRef:
       type: http
       url: https://raw.githubusercontent.com/syntasso/promise-postgresql/vX.Y.Z/promise.yaml
   ```

2. Push the pipeline image (the image tag is set in `workflows/configure-pipeline/Makefile`):
   ```shell
   cd workflows/configure-pipeline && make push
   ```

3. Create and push the git tag:
   ```shell
   git tag vX.Y.Z && git push origin vX.Y.Z
   ```

The image must be pushed before the tag is created so that the image exists in the registry when users install the promise at that tag.

## Questions? Feedback?

We are always looking for ways to improve Kratix and the Marketplace. If you
run into issues or have ideas for us, please let us know. Feel free to [open an
issue](https://github.com/syntasso/kratix-marketplace/issues/new/choose) or
[put time on our calendar](https://www.syntasso.io/contact-us). We'd love to
hear from you.

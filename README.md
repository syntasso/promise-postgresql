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

Releases are automated via [release-please](https://github.com/googleapis/release-please). Version bumps are determined by [Conventional Commits](https://www.conventionalcommits.org/):

- `fix:` → patch bump
- `feat:` → minor bump
- `feat!:` or `BREAKING CHANGE:` → major bump

### Pre-releases (beta)

By default the project is in pre-release mode (`prerelease: true` in `.release-please-config.json`). On every push to `main`, release-please maintains a Release PR with the next `vX.Y.Z-beta.N` version. Merging that PR:

1. Creates the git tag (e.g. `v1.0.0-beta.5`)
2. Publishes the pipeline image to ghcr.io tagged as `v1.0.0-beta.5` — `latest` is not updated for pre-releases

### Stable releases

When ready to cut a stable release, open a PR that removes `"prerelease": true` from `.release-please-config.json`. Once merged, the next Release PR will target the stable version (e.g. `v1.0.0`). Merging that PR:

1. Creates the git tag (e.g. `v1.0.0`)
2. Publishes the pipeline image tagged as both `v1.0.0` and `latest`

### Returning to pre-releases

To start a new beta cycle after a stable release, open a PR re-adding `"prerelease": true` to `.release-please-config.json`. Subsequent releases will be `vX.Y.Z-beta.0`, `vX.Y.Z-beta.1`, etc. until `prerelease` is removed again.

## Questions? Feedback?

We are always looking for ways to improve Kratix and the Marketplace. If you
run into issues or have ideas for us, please let us know. Feel free to [open an
issue](https://github.com/syntasso/kratix-marketplace/issues/new/choose) or
[put time on our calendar](https://www.syntasso.io/contact-us). We'd love to
hear from you.

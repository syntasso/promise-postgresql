# PostgreSQL

This Promise provides PostgreSQL-as-a-Service.

## Request Fields

The Promise supports the following request fields:
- `.spec.env`
- `.spec.teamId`
- `.spec.dbName`
- `.spec.backupEnabled`

## Install

```bash
kubectl apply -f https://raw.githubusercontent.com/syntasso/promise-postgresql/main/promise.yaml
```

## Resource Requests

Default request (Kubernetes Secret credentials):

```bash
kubectl apply -f https://raw.githubusercontent.com/syntasso/promise-postgresql/main/resource-request.yaml
```

## Development

For development see [README.md](./internal/README.md)

## Questions? Feedback?

We are always looking for ways to improve Kratix and the Marketplace. If you
run into issues or have ideas for us, please let us know. Feel free to [open an
issue](https://github.com/syntasso/kratix-marketplace/issues/new/choose) or
[put time on our calendar](https://www.syntasso.io/contact-us). We'd love to
hear from you.

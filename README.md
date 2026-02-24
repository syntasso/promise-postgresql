# PostgreSQL

This Promise provides PostgreSQL-as-a-Service.

## Request Fields

The Promise supports the following request fields:
- `.spec.env`
- `.spec.teamId`
- `.spec.dbName`
- `.spec.backupEnabled`
- `.spec.vault` (optional)

## Install

```bash
kubectl apply -f https://raw.githubusercontent.com/syntasso/promise-postgresql/main/promise.yaml
```

## Resource Requests

Default request (Kubernetes Secret credentials):

```bash
kubectl apply -f https://raw.githubusercontent.com/syntasso/promise-postgresql/main/resource-request.yaml
```

Vault-enabled request (dynamic credentials):

```bash
kubectl apply -f https://raw.githubusercontent.com/syntasso/promise-postgresql/main/resource-request-vault.yaml
```

## Vault Setup (Optional)

If you enable `.spec.vault.enabled: true`, configure these prerequisites first:

1. Vault database secrets engine is enabled (`database/`).
2. Vault Kubernetes auth is enabled at `auth/kubernetes` (or use a custom path in the request).
3. Create a platform-cluster Secret used by the Promise pipelines:

```bash
kubectl -n default create secret generic postgresql-vault \
  --from-literal=address='https://vault.example.com' \
  --from-literal=token='<vault-token-with-policy-management-permissions>'
```

When Vault is enabled on a request, the pipeline creates:
- a per-resource Vault database config (`database/config/<derived-name>`)
- a Vault policy scoped to that database role
- a Vault Kubernetes auth role for the workload service account
- a Vault database role for dynamic Postgres credentials

By default, the Promise bootstrap job reads the Zalando-generated user Secret in the worker cluster and uses that username/password to configure Vault's database connection for the instance.
Vault database config naming, plugin name, and connection URL parameters are managed by the Promise and are not configurable per request.

## Development

For development see [README.md](./internal/README.md)

## Questions? Feedback?

We are always looking for ways to improve Kratix and the Marketplace. If you
run into issues or have ideas for us, please let us know. Feel free to [open an
issue](https://github.com/syntasso/kratix-marketplace/issues/new/choose) or
[put time on our calendar](https://www.syntasso.io/contact-us). We'd love to
hear from you.

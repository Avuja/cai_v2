# Environments and Fly app naming

Decision: Use a common prefix for all apps, with environments: dev, staging, prod.

Prefix: myapp
Fly org: your-fly-org
Primary region: iad (or nearest)

Apps (per environment):
- myapp-api: Express API
- myapp-keycloak: Keycloak IdP (PoC)
- myapp-pg: Single Postgres for PoC

Notes:
- For the PoC, one shared Postgres is acceptable; split later if needed.
- External app names on Fly may be preserved as we refactor internals.


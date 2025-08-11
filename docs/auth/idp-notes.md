# Identity Provider (IdP) configuration notes

Target: OIDC-compliant IdP (Keycloak for PoC)

Baseline decisions:
- Protocol: OpenID Connect (OIDC)
- Environments: dev, staging, prod
- Realms: single realm per environment for PoC
- Clients: backend API (confidential), web (public) if/when added

Keycloak checklist (per environment):
- Create realm: myapp-dev (etc.)
- Create client: myapp-api
  - Access type: confidential
  - Valid redirect URIs: https://myapp-api.fly.dev/*
  - Web origins: https://myapp-api.fly.dev
- Create initial test user
- Obtain discovery URL: https://myapp-keycloak.fly.dev/realms/myapp-dev/.well-known/openid-configuration
- Capture client credentials via secret manager

Notes:
- For local dev, use http://localhost:8080/* redirect URIs
- Enforce PKCE for public clients
- Rotate secrets for confidential clients


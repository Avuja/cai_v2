# cai_v2 — Fly.io GitHub Deployment Baseline

This is a minimal Express app demonstrating a GitHub-to-Fly.io deployment pipeline.

## Prerequisites
- Node.js 18+
- Git
- Flyctl (`flyctl auth login` to authenticate)

## Local development
- Install deps: `npm install`
- Run: `npm run dev`
- Test: open http://localhost:8080 and http://localhost:8080/health

## Deployment via GitHub Actions
1) Ensure `fly.toml` has your app name and primary region.
2) Create the Fly app: `flyctl apps create APP_NAME` (replace APP_NAME accordingly).
3) Generate a Fly API token: `flyctl auth token` and add it to your GitHub repo as a secret named `FLY_API_TOKEN`.
4) Push to `main` to trigger deployment. The app will be available at `https://APP_NAME.fly.dev`.

## Clean up
- Destroy app: `flyctl apps destroy APP_NAME`

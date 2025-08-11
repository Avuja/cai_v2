# LLM Agent Guide - Fly.io Deployment Baseline

**Target Audience:** Future AI coding assistants working with this codebase  
**Context:** This is a baseline/placeholder deployment for building actual applications  
**Last Updated:** 2025-08-11T22:58:54Z  

## 🤖 Quick Context for AI Agents

This repository contains a **baseline Express.js application** deployed to Fly.io via GitHub Actions. It serves as a foundation/template, not a final product. Future agents should expect to replace the placeholder application logic with actual business requirements.

### 🎯 What This Baseline Provides
- ✅ **Working Fly.io deployment pipeline**
- ✅ **GitHub Actions CI/CD automation**
- ✅ **Optimized Docker containerization**
- ✅ **Cost-effective auto-scaling configuration**
- ✅ **Health monitoring endpoints**
- ✅ **Error handling middleware**
- ✅ **Development workflow setup**

## 🚨 Critical Information for LLMs

### Current Deployment Status
- **Live URL**: https://avuja-cai-v2.fly.dev
- **Status**: Active placeholder deployment
- **Cost**: Minimal (auto-stops when idle)
- **Purpose**: Template/baseline for future applications

### ⚠️ Important Deployment Considerations

1. **This is a PLACEHOLDER deployment** - Replace with actual application logic
2. **Fly.io app name is taken** - If creating new apps, use different names
3. **GitHub secrets are configured** - `FLY_API_TOKEN` is already set
4. **Auto-scaling is optimized** - `min_machines_running = 0` for cost savings
5. **All dependencies are resolved** - No known deployment issues remain

## 🔄 Replacing This Baseline with Real Application

### Option 1: Modify in Place (Recommended)
```bash
# Keep existing infrastructure, replace application logic
# 1. Update src/ directory with new application code
# 2. Modify package.json dependencies as needed
# 3. Update fly.toml if different resource requirements
# 4. Commit and push - auto-deploys to same URL
```

### Option 2: Create New Fly App
```bash
# If you need a completely separate app
flyctl apps create new-app-name
# Update fly.toml with new app name
# Push changes - deploys to new URL: https://new-app-name.fly.dev
```

### Option 3: Destroy and Recreate
```bash
# If starting completely fresh
flyctl apps destroy avuja-cai-v2
flyctl apps create new-app-name
# Requires updating fly.toml and re-pushing
```

## 🏗️ Architecture Overview for LLMs

### File Structure Hierarchy
```
HIGH PRIORITY (modify these for new apps):
├── src/                        # Application logic - REPLACE THIS
│   ├── app.js                 # Main Express app - UPDATE
│   ├── server.js              # Server entry point - RARELY CHANGE
│   ├── routes/                # API routes - REPLACE WITH REAL ROUTES
│   └── middleware/            # Custom middleware - EXPAND AS NEEDED

MEDIUM PRIORITY (may need updates):
├── package.json               # Dependencies - UPDATE FOR NEW FEATURES
├── Dockerfile                 # Container config - UPDATE FOR NEW DEPS
├── fly.toml                   # Fly.io config - UPDATE FOR SCALING NEEDS

LOW PRIORITY (usually keep as-is):
├── .github/workflows/         # CI/CD - WORKING, rarely needs changes
├── .gitignore                 # Git exclusions - STANDARD
├── .dockerignore              # Docker exclusions - STANDARD
```

### Key Configuration Files

#### fly.toml - Deployment Configuration
```toml
app = "avuja-cai-v2"              # CHANGE THIS for new apps
primary_region = "iad"            # Good default for US East
min_machines_running = 0          # KEEP THIS for cost optimization
auto_stop_machines = true         # KEEP THIS for cost optimization
memory = "256mb"                  # INCREASE if app needs more RAM
```

#### package.json - Dependencies
```json
{
  "name": "cai_v2",              # Can change
  "main": "src/server.js",       # KEEP THIS path
  "engines": { "node": ">=18" }, # KEEP THIS requirement
  "scripts": {
    "start": "node src/server.js",    # REQUIRED for Fly.io
    "dev": "nodemon --watch src src/server.js"  # For development
  }
}
```

## 🐛 Known Issues & Solutions (From Experience)

### 1. Package Dependency Conflicts
**Problem**: `npm ci` fails with dependency mismatches
**Solution**: Always run `npm install` after modifying package.json
```bash
npm install              # Regenerates package-lock.json
git add package-lock.json
git commit -m "Update dependencies"
```

### 2. Docker Build Failures
**Problem**: User creation errors in Alpine Linux
**Solution**: Don't create users that already exist
```dockerfile
# WRONG - node user already exists
RUN adduser -S node -u 1001

# RIGHT - just change ownership
RUN chown -R node:node /app
USER node
```

### 3. Fly.io Deployment Authentication
**Problem**: "No access token available"
**Solution**: Ensure FLY_API_TOKEN secret is set in GitHub
```bash
# Generate token
flyctl auth token

# Add to GitHub: Repo → Settings → Secrets → Actions → New secret
# Name: FLY_API_TOKEN
# Value: [token from above command]
```

### 4. App Name Conflicts
**Problem**: "App name already taken"
**Solution**: Choose unique app names
```bash
# Check if name is available
flyctl apps create test-unique-name-123

# If taken, try variations
flyctl apps create your-project-name-$(date +%s)
```

## 🔧 Development Workflow for LLMs

### Local Development
```bash
# 1. Install dependencies
npm install

# 2. Run in development mode (auto-reload)
npm run dev

# 3. Test endpoints
curl http://localhost:8080/
curl http://localhost:8080/health
curl http://localhost:8080/api/hello
```

### Deployment Workflow
```bash
# 1. Make changes to src/
# 2. Test locally
# 3. Commit and push
git add .
git commit -m "Update application logic"
git push origin main

# 4. GitHub Actions automatically deploys
# 5. Check deployment at fly.io URL
```

### Debugging Deployments
```bash
# Check app status
flyctl status

# View live logs
flyctl logs

# Access app shell for debugging
flyctl ssh console

# Force restart if needed
flyctl machine restart [machine-id]
```

## 📝 Common Modifications for LLMs

### Adding Database Support
```javascript
// src/app.js - Add database connection
const database = require('./database');
app.use('/api', database.router);
```

```toml
# fly.toml - Add database service
[[services]]
  internal_port = 5432
  protocol = "tcp"
```

### Adding Authentication
```javascript
// src/middleware/auth.js
const auth = require('./auth');
app.use('/api', auth.requireAuth);
```

### Environment Variables
```toml
# fly.toml
[env]
  NODE_ENV = "production"
  DATABASE_URL = "postgres://..."
  API_SECRET = "use-fly-secrets-for-this"
```

```bash
# Set secrets (not in toml)
flyctl secrets set API_SECRET=your-secret-value
```

### Scaling for Production
```toml
# fly.toml - For higher traffic apps
[[vm]]
  size = "shared-cpu-2x"         # More CPU
  memory = "512mb"               # More RAM

[http_service]
  min_machines_running = 1       # Always-on
  
  [http_service.concurrency]
    soft_limit = 100             # Higher concurrency
    hard_limit = 200
```

## 🎯 LLM Best Practices

### 1. **Always Check Current Status First**
```bash
flyctl status                   # Check deployment state
flyctl logs --region iad        # Check for errors
git log --oneline -5            # Check recent commits
```

### 2. **Incremental Changes**
- Make small, testable changes
- Test locally before pushing
- Monitor deployment logs after each push
- Keep commits focused and descriptive

### 3. **Resource Monitoring**
```bash
flyctl metrics                  # Check resource usage
flyctl scale show              # Check current scaling
flyctl regions list            # Available regions
```

### 4. **Error Recovery**
```bash
# If deployment fails
flyctl deploy --remote-only     # Force redeploy
flyctl machine restart $(flyctl machine list -j | jq -r '.[0].id')
flyctl logs --region iad        # Check error messages
```

## 📚 Reference Links for LLMs

- **Fly.io Documentation**: https://fly.io/docs/
- **GitHub Repository**: https://github.com/Avuja/cai_v2
- **Live Application**: https://avuja-cai-v2.fly.dev
- **GitHub Actions**: https://github.com/Avuja/cai_v2/actions

## 🚀 Quick Start Checklist for New Applications

### Phase 1: Preparation
- [ ] Understand user requirements
- [ ] Decide: modify existing app or create new one
- [ ] Check if additional Fly.io services needed (database, Redis, etc.)

### Phase 2: Development
- [ ] Update `src/` with new application logic
- [ ] Modify `package.json` dependencies
- [ ] Update `fly.toml` if different resources needed
- [ ] Test locally with `npm run dev`

### Phase 3: Deployment
- [ ] Commit changes with descriptive message
- [ ] Push to main branch
- [ ] Monitor GitHub Actions deployment
- [ ] Validate endpoints are working
- [ ] Check Fly.io logs for issues

### Phase 4: Optimization
- [ ] Monitor resource usage with `flyctl metrics`
- [ ] Adjust scaling settings if needed
- [ ] Set up proper error monitoring
- [ ] Document any new endpoints or features

## ⚠️ Things NOT to Change (Unless Necessary)

- `.github/workflows/fly-deploy.yml` - CI/CD is working perfectly
- `src/server.js` - Basic HTTP server setup is standard
- `Dockerfile` - Optimized for Node.js production deployment
- Auto-scaling settings - Already optimized for cost-effectiveness

## 💡 Pro Tips for LLMs

1. **Always preserve the health endpoint** - Critical for Fly.io monitoring
2. **Keep error handling middleware** - Improves debugging significantly  
3. **Maintain the existing project structure** - Well-organized and tested
4. **Use semantic commit messages** - Helps with deployment tracking
5. **Test endpoints after deployment** - Don't assume success without validation

---

*This guide should enable any future LLM to quickly understand, modify, and build upon this Fly.io deployment baseline without repeating the setup and troubleshooting process.*

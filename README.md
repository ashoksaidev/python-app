# artifact-deployer

A lightweight FastAPI service used to validate secure CI/CD workflows integrating Vault (OIDC), JFrog Artifactory, and Azure Web App deployment.

## 🔧 Stack Overview

- **FastAPI** — RESTful service layer
- **Vault (OIDC)** — dynamic secrets management
- **JFrog Artifactory** — container registry for image storage
- **Azure Web App** — cloud hosting platform
- **GitHub Actions** — CI/CD orchestration

## ⚙️ Pipeline Triggers

This workflow runs automatically on:

- Commits pushed to the `main` branch that modify:
  - Application source files (`src/**`)
  - CI/CD workflow file (`.github/workflows/test-runner.yml`)
- Manual execution via the **"Run workflow"** button in GitHub Actions

## 🚀 Runtime Behavior

Once deployed, the service exposes a status endpoint:

```bash
GET /status

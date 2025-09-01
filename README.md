# Artifact Deployment Service

This project automates deployment of Python services using **FastAPI**, **Docker**, **GitHub Actions**, **JFrog Artifactory**, and **Azure App Services** (Web App) or **Azure VM**.

---

## Project Structure
- `src/app/main.py` → FastAPI application
- `tests/test_status.py` → Functional test using TestClient
- `Dockerfile` → Multi-stage build using Chainguard images
- `.github/workflows/deploy.yml` → CD workflow to deploy image to VM or Azure Web App
- `.github/workflows/codeql.yml` → Static code analysis
- `.github/dependabot.yml` → Dependency updates

---

## Required GitHub Secrets
The following **GitHub Secrets** must be configured:

- `ARTIFACTORY_URL`
- `DOCKER_REPO`
- `ARTIFACTORY_USER`
- `ARTIFACTORY_PASSWORD`
- `VM_SSH_KEY`
- `AZURE_CREDENTIALS`
- `AZURE_RESOURCE_GROUP`
- `AZURE_WEBAPP_NAME`

---

## CI/CD Flow
1. **CI** builds and pushes Docker image to Artifactory.  
2. Uploads `image-tag.txt` with the image reference.  
3. **CD** is triggered manually with `image_tag` input.  
4. Deploys either to:
   - Azure Web App (PaaS)  
   - or Azure VM (IaaS with Docker).  

---

## Recommendations
- Use GitHub Secrets (no Vault required).  
- Pin GitHub Actions to stable versions.  
- Ensure runners have network access to Artifactory.  
- Use semantic commit messages for clarity.

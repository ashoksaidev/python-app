# Artifact Deployment Service

This project automates deployment of Python services using **FastAPI**, **Docker**, **GitHub Actions**, **JFrog Artifactory**, and **Azure**.

---

## 📂 Project Structure
- `src/app/main.py` → FastAPI application
- `tests/test_status.py` → Functional test using TestClient
- `Dockerfile` → Multi-stage build using Chainguard images
- `.github/workflows/ci.yml` → CI workflow to build, test, scan, and publish image
- `.github/workflows/deploy.yml` → CD workflow to deploy image to VM or Azure Web App
- `.github/dependabot.yml` → Dependency updates

---

## 🔑 Required GitHub Secrets

To run CI/CD pipelines, configure these secrets in your GitHub repository:  
*(replace placeholders with your actual values in **GitHub Secrets**, never commit them in code)*

| Secret Name            | Example Value                                       | Purpose |
|-------------------------|-----------------------------------------------------|---------|
| `ARTIFACTORY_URL`      | `trialbgccpz.jfrog.io`                              | JFrog registry base URL |
| `DOCKER_REPO`          | `docker-local`                                      | JFrog Docker repo name |
| `ARTIFACTORY_USER`     | `<your-username-or-email>`                          | JFrog username (e.g., your JFrog account email) |
| `ARTIFACTORY_PASSWORD` | `<your-api-key-or-token>`                           | JFrog API key / token for authentication |
| `VM_SSH_KEY`           | `-----BEGIN OPENSSH PRIVATE KEY----- ...`           | Private SSH key to connect to Azure VM |
| `AZURE_CREDENTIALS`    | `{ "clientId": "...", "clientSecret": "...", "tenantId": "...", "subscriptionId": "..." }` | Azure Service Principal for authentication |
| `AZURE_RESOURCE_GROUP` | `my-resource-group`                                 | Azure Resource Group where the Web App is hosted |
| `AZURE_WEBAPP_NAME`    | `python-gradle-app`                                 | Azure Web App name |

---

## 🚀 CI/CD Flow
1. **CI Workflow** → builds and pushes Docker image to JFrog Artifactory.  
2. **CD Workflow** → triggered manually with an `image_tag`.  
3. **Deployment** → depending on `deploy_target`, deploys either to:
   - **Azure VM** (via SSH + Docker)  
   - **Azure Web App** (via `az webapp config container set`)  

---

⚠️ **Note:**  
- Never hardcode secrets in YAML files or source code.  
- Use **GitHub Secrets** for sensitive values (Artifactory, Azure, SSH keys).  
- Rotate API keys/tokens regularly for security.  

---


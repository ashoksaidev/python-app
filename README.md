Artifact Deployment Service

This project automates deployment of Python services using FastAPI, Docker, GitHub Actions, JFrog Artifactory, and HashiCorp Vault.

Project Structure

- src/app/main.py: FastAPI application  
- tests/test_status.py: Functional test using TestClient  
- Dockerfile: Multi-stage build using Chainguard images  
- .github/workflows/ci.yml: CI workflow to build, test, scan, and publish image  
- .github/workflows/deploy.yml: CD workflow to deploy image to VM or Azure Web App  
- .github/workflows/codeql.yml: Static code analysis  
- .github/dependabot.yml: Dependency updates

Required Secrets

Vault must expose the path ci/data/artifactory with these keys:  
- url → ARTIFACTORY_URL  
- repo_docker → DOCKER_REPO  
- username → ARTIFACTORY_USER  
- password → ARTIFACTORY_PASSWORD

Other required secrets:  
- VAULT_ADDR  
- VAULT_NAMESPACE  
- AZURE_CREDENTIALS  
- AZURE_RESOURCE_GROUP  
- AZURE_WEBAPP_NAME  
- KUBECONFIG (if using Kubernetes)  
- VM_SSH_KEY  
- HEALTHCHECK_URL (optional)

Vault Setup

- Enable GitHub OIDC authentication  
- Create a role named gh-actions with audience https://github.com/your-org  
- Store credentials under ci/data/artifactory using KV v2

CI/CD Flow

- CI builds and pushes Docker image to Artifactory  
- Uploads image-tag.txt with the image reference  
- CD is triggered manually with image_tag input  
- Deploys to Azure Web App or VM

Recommendations

- Remove Vault debug step from deploy.yml after setup  
- Pin GitHub Actions to stable versions  
- Ensure runners have network access to Vault and Artifactory  
- Use semantic commit messages for clarity

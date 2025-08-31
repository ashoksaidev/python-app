```markdown
# Artifact Deployment Service - repository layout and CI/CD

This repository contains:
- src/app/main.py - FastAPI application (status endpoint).
- tests/test_status.py - functional test using TestClient.
- Dockerfile - multi-stage Chainguard-based image.
- .github/workflows/ci.yml - CI: build, test, scan, publish to JFrog Artifactory.
- .github/workflows/deploy.yml - CD: deploy image from Artifactory to k8s / azure / VM using HashiCorp Vault for secrets.
- .github/workflows/codeql.yml - CodeQL analysis.
- .github/dependabot.yml - Dependabot config.

Required repository secrets
- VAULT_ADDR: full URL to Vault (include https:// and port if needed, e.g. https://vault.example.com:8200)
- VAULT_NAMESPACE: (if using Vault namespaces) or empty string
- AZURE_CREDENTIALS: service principal JSON (for azure deployment)
- AZURE_RESOURCE_GROUP: name of resource group (for azure deployment)
- AZURE_WEBAPP_NAME: name of the Azure Web App (for azure deployment)
- KUBECONFIG: kubeconfig file content (for kubernetes deployment)
- VM_SSH_KEY: private key text for VM SSH deploy (for vm deploy target)
- HEALTHCHECK_URL: optional healthcheck URL (used by deploy workflow)
- NOTE: The Vault action expects the Vault KV path `ci/data/artifactory` with keys:
  - url (ARTIFACTORY_URL)
  - repo_docker (DOCKER_REPO)
  - username (ARTIFACTORY_USER)
  - password (ARTIFACTORY_PASSWORD)

Vault setup
- Configure OIDC auth for GitHub in Vault and create a role `gh-actions` with the audience `https://github.com/<your-org>`.
- Store Artifactory credentials at `ci/data/artifactory` (KV v2 recommended).

How CI -> CD works
- CI builds and pushes an image to Artifactory and uploads a small artifact file image-tag.txt containing the pushed image tag.
- Use the value from CI logs or image-tag artifact to trigger the Deploy workflow (workflow_dispatch) and pass `image_tag` as input.

Notes and recommendations
- Remove the "Debug: check Vault reachability" step from deploy.yml after verification.
- Pin actions to specific release tags (we pinned Trivy to 0.31.0 here).
- Ensure your self-hosted runner (if used) has network access to Vault and Artifactory.
```

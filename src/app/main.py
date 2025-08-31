import os
from fastapi import FastAPI
from fastapi.responses import JSONResponse

app = FastAPI(
    title="CI/CD Artifact Deployment API",
    version="1.0.0",
    description="API service for monitoring and managing artifact deployments across environments."
)

# Load Vault-injected environment variables
ARTIFACTORY_URL = os.getenv("ARTIFACTORY_URL", "not-configured")
DOCKER_REPO = os.getenv("DOCKER_REPO", "not-configured")
ARTIFACTORY_USER = os.getenv("ARTIFACTORY_USER", "not-configured")

@app.get("/health", summary="Health Check Endpoint", response_description="Service health status")
def health_check():
    return JSONResponse(
        status_code=200,
        content={
            "status": "healthy",
            "service": "ci-cd-artifact-deployment",
            "message": "Deployment service is running successfully",
            "artifactoryConfigured": ARTIFACTORY_URL != "not-configured"
        }
    )

from fastapi import FastAPI

app = FastAPI(title="CI/CD Artifact Deployment Service")


@app.get("/health")
def health_check():
    return {
        "status": "healthy",
        "service": "ci-cd-artifact-deployment"
    }

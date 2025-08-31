from fastapi import FastAPI
from fastapi.responses import JSONResponse

app = FastAPI(
    title="CI/CD Artifact Deployment API",
    version="1.0.0",
    description="API service for monitoring and managing artifact deployments across environments."
)

@app.get("/health", summary="Health Check Endpoint", response_description="Service health status")
def health_check():
    return JSONResponse(
        status_code=200,
        content={
            "status": "healthy",
            "service": "ci-cd-artifact-deployment",
            "message": "Deployment service is running successfully"
        }
    )

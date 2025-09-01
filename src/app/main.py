from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI(
    title="CI/CD Artifact Deployment API",
    version="1.0.0",
    description="API service for monitoring and managing artifact deployments across environments."
)

class HealthResponse(BaseModel):
    status: str
    service: str
    message: str

@app.get("/", summary="Root Endpoint")
def root():
    return {"message": "Welcome to the Artifact Deployment Service API"}

@app.get("/health", response_model=HealthResponse, summary="Health Check Endpoint", response_description="Service health status")
def health_check():
    return {
        "status": "healthy",
        "service": "ci-cd-artifact-deployment",
        "message": "Deployment service is running successfully"
    }

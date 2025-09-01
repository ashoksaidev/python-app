from fastapi.testclient import TestClient
from app.main import app  # Adjust import path if needed

client = TestClient(app)

def test_health_check_endpoint():
    response = client.get("/health")
    assert response.status_code == 200
    data = response.json()
    assert data["status"] == "healthy"
    assert data["service"] == "ci-cd-artifact-deployment"
    assert data["message"] == "Deployment service is running successfully"

def test_root_endpoint():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json()["message"] == "Welcome to the Artifact Deployment Service API"

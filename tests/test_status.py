from fastapi.testclient import TestClient
from app.main import app  # Adjust import path if your app is located elsewhere

client = TestClient(app)

def test_health_check_endpoint():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json()["status"] == "healthy"
    assert response.json()["service"] == "ci-cd-artifact-deployment"

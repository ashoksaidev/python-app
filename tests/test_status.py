from fastapi.testclient import TestClient
from app.main import app  # src/ is added to PYTHONPATH in Docker

client = TestClient(app)

def test_health_check_endpoint():
    response = client.get("/health")
    assert response.status_code == 200
    body = response.json()
    assert body["status"] == "healthy"
    assert body["service"] == "ci-cd-artifact-deployment"
    assert isinstance(body["artifactoryConfigured"], bool)

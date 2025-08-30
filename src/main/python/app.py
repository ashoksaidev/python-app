from fastapi import FastAPI

app = FastAPI(title="Artifact Deployment Service", version="1.0.0")

@app.get("/status")
def get_service_status():
    return {"status": "ok", "message": "Artifact deployment pipeline is live"}

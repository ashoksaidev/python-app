# --------------------------------------------------------------------
# Multi-stage Dockerfile for CI/CD Artifact Deployment Service
# --------------------------------------------------------------------

# Stage 1: Build environment
FROM cgr.dev/chainguard/python:latest-dev AS build-stage

WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app source
COPY src/ src/

# --------------------------------------------------------------------
# Stage 2: Runtime environment
FROM cgr.dev/chainguard/python:latest AS runtime-stage

WORKDIR /app

COPY --from=build-stage /app /app

ENV PYTHONPATH=/app/src

EXPOSE 8080

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]

# ------------------------------------------------------------
# Multi-stage Dockerfile for FastAPI deployment
# Stage 1: Build environment using Chainguard dev image
# ------------------------------------------------------------
FROM cgr.dev/chainguard/python:latest-dev AS build-env
WORKDIR /opt/app

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application source code
COPY src/ ./src/

# ------------------------------------------------------------
# Stage 2: Runtime environment using minimal Chainguard image
# ------------------------------------------------------------
FROM cgr.dev/chainguard/python:latest AS runtime-env
WORKDIR /opt/app

# Copy built app from build stage
COPY --from=build-env /opt/app /opt/app

# Expose FastAPI default port
EXPOSE 8080

# Launch FastAPI app using Uvicorn
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]

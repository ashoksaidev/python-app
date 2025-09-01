# ------------------------------------------------------------------------------
# Multi-stage Dockerfile for CI/CD Artifact Deployment Service
# ------------------------------------------------------------------------------

# Stage 1: Build environment using Chainguard Python dev image
FROM cgr.dev/chainguard/python:3.11-dev AS build-stage

# Set working directory for build
WORKDIR /app

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application source code
COPY src/ src/

# ------------------------------------------------------------------------------
# Stage 2: Runtime environment using minimal Chainguard Python image
FROM cgr.dev/chainguard/python:3.11 AS runtime-stage

# Set working directory for runtime
WORKDIR /app

# Copy built app and dependencies from build stage
COPY --from=build-stage /app /app

# Set Python path to include source directory
ENV PYTHONPATH=/app/src

# Expose application port
EXPOSE 8080

# Run as non-root user (for security, if available)
USER nonroot

# Start FastAPI application using Uvicorn
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]

# ------------------------------------------------------------------------------
# Multi-stage Dockerfile for CI/CD Artifact Deployment Service
# - Uses official python:3.11-slim to avoid tag resolution issues
# - Installs deps into /opt/venv in build stage and copies to runtime
# ------------------------------------------------------------------------------

# === Stage 1: Build ===
FROM python:3.11-slim AS build

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# (Optional) system build deps for wheels
RUN apt-get update && apt-get install -y --no-install-recommends \
      build-essential gcc \
    && rm -rf /var/lib/apt/lists/*

# Create a virtualenv and install dependencies
COPY requirements.txt .
RUN python -m venv /opt/venv \
 && . /opt/venv/bin/activate \
 && pip install --upgrade pip \
 && pip install --no-cache-dir -r requirements.txt

# Copy application source
COPY src/ src/

# === Stage 2: Runtime ===
FROM python:3.11-slim AS runtime

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# Copy the virtualenv and application code from build stage
COPY --from=build /opt/venv /opt/venv
COPY --from=build /app/src /app/src

# Ensure our venv is used
ENV PATH="/opt/venv/bin:$PATH" \
    PYTHONPATH="/app/src"

# Expose application port used by Uvicorn
EXPOSE 8080

# Run as non-root for security
RUN useradd -m -u 10001 appuser
USER appuser

# Start FastAPI app
# Expecting your entrypoint at src/app/main.py with "app = FastAPI(...)"
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]

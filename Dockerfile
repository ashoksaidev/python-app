# Multi-stage Dockerfile using Chainguard base images
# Stage 1: build environment
FROM cgr.dev/chainguard/python:latest-dev AS build-env
WORKDIR /opt/app

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application source code
COPY src/ ./src/

# Stage 2: runtime environment with minimal Chainguard image
FROM cgr.dev/chainguard/python:latest AS runtime-env
WORKDIR /opt/app

# Copy source and installed packages from build stage (if packages installed to site-packages inside image)
COPY --from=build-env /opt/app /opt/app

# Ensure python can find package under /opt/app/src
ENV PYTHONPATH=/opt/app/src

EXPOSE 8080

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]

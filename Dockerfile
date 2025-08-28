# Stage 1: Build with Chainguard dev image
FROM cgr.dev/chainguard/python:latest-dev AS builder
WORKDIR /app

# Install dependencies if requirements.txt exists
COPY requirements.txt . 
RUN pip install --no-cache-dir -r requirements.txt || true

# Copy source code
COPY . .

# Stage 2: Runtime with minimal Chainguard image
FROM cgr.dev/chainguard/python:latest
WORKDIR /app

# Copy built app from builder stage
COPY --from=builder /app /app

# Run your app
CMD ["python", "main/python/app.py"]

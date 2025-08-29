# Stage 1: Build with Chainguard dev image
FROM cgr.dev/chainguard/python:latest-dev AS builder
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy source code
COPY . .

# Stage 2: Runtime with minimal Chainguard image
FROM cgr.dev/chainguard/python:latest
WORKDIR /app

# Copy built app from builder stage
COPY --from=builder /app /app

# Expose FastAPI port
EXPOSE 8080

# Run FastAPI app using Uvicorn
CMD ["uvicorn", "src.app:app", "--host", "0.0.0.0", "--port", "8080"]

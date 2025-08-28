# Stage 1: Build with Chainguard dev image
FROM cgr.dev/chainguard/python:latest-dev AS builder
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy source code
COPY . .

# Stage 2: Runtime with minimal image
FROM cgr.dev/chainguard/python:latest
WORKDIR /app

# Copy everything from builder stage
COPY --from=builder /app /app

# Run the app
CMD ["python", "main/python/app.py"]

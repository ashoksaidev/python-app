# Stage 1: Build with dev image
FROM cgr.dev/chainguard/python:latest-dev AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .

# Stage 2: Runtime with minimal image
FROM cgr.dev/chainguard/python:latest
WORKDIR /app
COPY --from=builder /app /app
CMD ["python", "main.py"]

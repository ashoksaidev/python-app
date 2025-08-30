FROM cgr.dev/chainguard/python:latest-dev AS build-env
WORKDIR /opt/app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY src/ ./src/

FROM cgr.dev/chainguard/python:latest AS runtime-env
WORKDIR /opt/app

COPY --from=build-env /opt/app /opt/app
ENV PYTHONPATH=/opt/app/src

EXPOSE 8080
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]

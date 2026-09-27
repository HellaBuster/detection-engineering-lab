FROM ghcr.io/astral-sh/uv:0.12.19 AS uv-bin

FROM python:3.13.15-slim-bookworm AS base
COPY --from=uv-bin /uv /uvx /bin/
WORKDIR /app
ENV UV_LINK_MODE=copy \
    UV_COMPILE_BYTECODE=1 \
    PYTHONUNBUFFERED=1
COPY pyproject.toml uv.lock ./

FROM base AS api
RUN uv sync --frozen --no-default-groups --group api --group observability
COPY services ./services
CMD ["/app/.venv/bin/uvicorn", "services.api.app:app", "--host", "0.0.0.0", "--port", "8000"]

FROM base AS mlflow
RUN uv sync --frozen --no-default-groups --group ml --group api
RUN mkdir -p /mlartifacts
CMD ["/app/.venv/bin/mlflow", "server", "--host", "0.0.0.0", "--port", "5000", "--serve-artifacts", "--artifacts-destination", "/mlartifacts"]

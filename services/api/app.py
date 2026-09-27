from __future__ import annotations

import os
import time
from collections.abc import Awaitable, Callable

from fastapi import FastAPI, Request, Response, status
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from prometheus_client import CONTENT_TYPE_LATEST, Counter, Histogram, generate_latest
from sqlalchemy import create_engine, text

DATABASE_URL = os.getenv(
    "DATABASE_URL",
    "postgresql+psycopg://detection_lab:detection_lab@127.0.0.1:55432/detection_lab",
)

engine = create_engine(DATABASE_URL, pool_pre_ping=True)
REQUESTS = Counter("lab_http_requests_total", "HTTP requests", ["method", "path", "status"])
LATENCY = Histogram("lab_http_request_duration_seconds", "HTTP request latency", ["path"])

app = FastAPI(title="Detection Engineering Lab", version="0.1.0")
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://127.0.0.1:5173", "http://localhost:5173"],
    allow_methods=["GET"],
    allow_headers=["*"],
)


@app.middleware("http")
async def observe_request(
    request: Request,
    call_next: Callable[[Request], Awaitable[Response]],
) -> Response:
    started = time.perf_counter()
    response = await call_next(request)
    path = request.url.path
    REQUESTS.labels(request.method, path, response.status_code).inc()
    LATENCY.labels(path).observe(time.perf_counter() - started)
    return response


@app.get("/health/live")
def live() -> dict[str, str]:
    return {"status": "ok", "service": "api"}


@app.get("/health/ready")
def ready() -> JSONResponse:
    try:
        with engine.connect() as connection:
            database_time = connection.execute(text("SELECT CURRENT_TIMESTAMP")).scalar_one()
    except Exception as exc:
        return JSONResponse(
            status_code=status.HTTP_503_SERVICE_UNAVAILABLE,
            content={"status": "not-ready", "database": type(exc).__name__},
        )
    return JSONResponse(content={"status": "ready", "database_time": str(database_time)})


@app.get("/metrics", include_in_schema=False)
def metrics() -> Response:
    return Response(content=generate_latest(), media_type=CONTENT_TYPE_LATEST)


def configure_telemetry() -> None:
    endpoint = os.getenv("OTEL_EXPORTER_OTLP_ENDPOINT")
    if not endpoint:
        return

    from opentelemetry import trace
    from opentelemetry.exporter.otlp.proto.grpc.trace_exporter import OTLPSpanExporter
    from opentelemetry.instrumentation.fastapi import FastAPIInstrumentor
    from opentelemetry.instrumentation.sqlalchemy import SQLAlchemyInstrumentor
    from opentelemetry.sdk.resources import Resource
    from opentelemetry.sdk.trace import TracerProvider
    from opentelemetry.sdk.trace.export import BatchSpanProcessor

    provider = TracerProvider(resource=Resource.create({"service.name": "detection-lab-api"}))
    exporter = OTLPSpanExporter(endpoint=endpoint, insecure=True)
    provider.add_span_processor(BatchSpanProcessor(exporter))
    trace.set_tracer_provider(provider)
    FastAPIInstrumentor.instrument_app(app)
    SQLAlchemyInstrumentor().instrument(engine=engine)


configure_telemetry()

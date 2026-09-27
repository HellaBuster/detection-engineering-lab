from fastapi.testclient import TestClient

from services.api.app import app


def test_live_health() -> None:
    response = TestClient(app).get("/health/live")

    assert response.status_code == 200
    assert response.json() == {"status": "ok", "service": "api"}

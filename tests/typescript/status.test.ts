import { describe, expect, it } from "vitest";

import { normalizeReadyState } from "../../services/frontend/src/status";

describe("normalizeReadyState", () => {
  it("accepts a ready API response", () => {
    expect(normalizeReadyState(true, { status: "ready" })).toEqual({
      api: "ready",
      database: "ready",
      message: "End-to-end окружение готово",
    });
  });

  it("rejects malformed state", () => {
    expect(normalizeReadyState(true, { status: "ok" }).api).toBe("error");
  });
});

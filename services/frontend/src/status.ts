export type ReadyState = {
  api: "ready" | "error";
  database: "ready" | "error";
  message: string;
};

export function normalizeReadyState(ok: boolean, payload: unknown): ReadyState {
  const ready =
    ok &&
    typeof payload === "object" &&
    payload !== null &&
    "status" in payload &&
    payload.status === "ready";

  return ready
    ? {
        api: "ready",
        database: "ready",
        message: "End-to-end окружение готово",
      }
    : {
        api: "error",
        database: "error",
        message: "Окружение требует проверки",
      };
}

import "./style.css";
import { normalizeReadyState } from "./status";

const apiState = document.querySelector<HTMLElement>("#api-state");
const databaseState = document.querySelector<HTMLElement>("#database-state");
const status = document.querySelector<HTMLElement>("#status");

async function checkEnvironment(): Promise<void> {
  try {
    const response = await fetch("/api/health/ready");
    const payload: unknown = await response.json();
    const state = normalizeReadyState(response.ok, payload);
    if (apiState) apiState.textContent = state.api;
    if (databaseState) databaseState.textContent = state.database;
    if (status) status.textContent = state.message;
  } catch {
    if (apiState) apiState.textContent = "unreachable";
    if (databaseState) databaseState.textContent = "unknown";
    if (status) status.textContent = "API недоступен";
  }
}

void checkEnvironment();

import { defineConfig } from "@playwright/test";

export default defineConfig({
  testDir: "tests/e2e",
  timeout: 30_000,
  retries: 1,
  reporter: [
    ["line"],
    ["html", { open: "never", outputFolder: ".artifacts/playwright-report" }],
  ],
  use: {
    baseURL: process.env.PLAYWRIGHT_BASE_URL ?? "http://127.0.0.1:5173",
    trace: "retain-on-failure",
  },
  outputDir: ".artifacts/playwright-results",
});

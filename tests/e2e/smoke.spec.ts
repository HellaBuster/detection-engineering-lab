import { expect, test } from "@playwright/test";

test("frontend observes the API and database", async ({ page }) => {
  await page.goto("/");

  await expect(
    page.getByRole("heading", { name: "Detection Engineering Lab" }),
  ).toBeVisible();
  await expect(page.getByRole("status")).toHaveText(
    "End-to-end окружение готово",
  );
  await expect(page.locator("#api-state")).toHaveText("ready");
  await expect(page.locator("#database-state")).toHaveText("ready");
});

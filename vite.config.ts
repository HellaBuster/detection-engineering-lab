import { defineConfig } from "vitest/config";

export default defineConfig({
  root: "services/frontend",
  server: {
    host: "0.0.0.0",
    port: 5173,
    allowedHosts: ["frontend"],
    proxy: {
      "/api": {
        target: "http://api:8000",
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/api/, ""),
      },
    },
  },
  preview: {
    host: "0.0.0.0",
    port: 5173,
  },
  test: {
    include: ["../../tests/typescript/**/*.test.ts"],
  },
});

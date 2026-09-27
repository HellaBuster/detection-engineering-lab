FROM node:24.21.0-bookworm-slim AS dependencies
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci

FROM dependencies AS frontend
COPY tsconfig.json vite.config.ts ./
COPY services/frontend ./services/frontend
EXPOSE 5173
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]

FROM mcr.microsoft.com/playwright:v1.63.0-noble AS playwright
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY playwright.config.ts tsconfig.json ./
COPY tests/e2e ./tests/e2e
CMD ["npm", "run", "test:e2e"]

# syntax=docker/dockerfile:1
FROM node:20-alpine

ENV NODE_ENV=production
WORKDIR /app

COPY package*.json ./
RUN npm ci --omit=dev

COPY src ./src
RUN addgroup -g 1001 -S nodejs && adduser -S node -u 1001 -G nodejs && chown -R node:node /app
USER node

EXPOSE 8080
ENV PORT=8080
CMD ["node", "src/server.js"]

# syntax=docker/dockerfile:1
FROM node:20-alpine

ENV NODE_ENV=production
WORKDIR /app

COPY package*.json ./
RUN npm ci --omit=dev

COPY src ./src
RUN chown -R node:node /app
USER node

EXPOSE 8080
ENV PORT=8080
CMD ["node", "src/server.js"]

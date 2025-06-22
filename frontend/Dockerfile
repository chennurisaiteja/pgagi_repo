FROM node:18 AS deps
WORKDIR /app
COPY frontend/package*.json ./
RUN npm install

FROM node:18 AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY frontend .
RUN npm run build

FROM node:18 AS runner
WORKDIR /app
ENV NODE_ENV=production
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/package.json ./
RUN npm install --production
EXPOSE 3000
CMD ["npm", "start"]


# Сборка
FROM node:16.20.0-alpine3.18 as builder
WORKDIR /usr/src/app
COPY . .
RUN npm install && npm run build

# Запуск
FROM nginx:stable-alpine3.17-slim
WORKDIR /app
COPY ./default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /usr/src/app/dist/frontend ./frontend
EXPOSE 80

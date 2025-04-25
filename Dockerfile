FROM alpine:latest

ARG PB_VERSION=0.27.1

RUN apk add --no-cache \
    unzip \
    ca-certificates

# Скачиваем и распаковываем binary вне каталога /edu
ADD https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /tmp/ \
    && chmod +x /tmp/pocketbase \
    && mv /tmp/pocketbase /usr/local/bin/pocketbase

# Создаём точку для данных (сюда будет монтироваться том)
RUN mkdir -p /edu/pocketbase

EXPOSE 8080

# Запускаем сервер, указывая dir на смонтированный том
CMD ["pocketbase", "serve", "--http=0.0.0.0:8080", "--dir=/edu/pocketbase"]

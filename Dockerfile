# Build go
FROM golang:1.23.2-alpine AS builder
WORKDIR /app
COPY . .
ENV CGO_ENABLED=0
RUN go mod download
RUN go build -v -o V2bX -tags "sing xray hysteria2 with_reality_server with_quic with_grpc with_utls with_wireguard with_acme"

# Release
FROM  alpine
# 安装必要的工具包
RUN  apk --update --no-cache add tzdata ca-certificates \
    && cp /usr/share/zoneinfo/America/Mexico_City /etc/localtime
RUN mkdir /etc/V2bX/
COPY --from=builder /app/V2bX /usr/local/bin
# Copiar el archivo config.json desde el repositorio al contenedor
COPY config.json /etc/V2bX/config.json
COPY fullchain.cer /etc/V2bX/fullchain.cer
COPY cc1.demianred.site.key /etc/V2bX/cc1.demianred.site.key
EXPOSE 443
ENTRYPOINT [ "V2bX", "server", "--config", "/etc/V2bX/config.json"]

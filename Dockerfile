FROM golang:1.14-alpine as builder

WORKDIR /app

RUN apk add --no-cache upx ca-certificates tzdata
COPY ./go.mod ./
COPY ./go.sum ./
RUN go mod download
COPY . .

RUN CGO_ENABLED=0 go build -ldflags "-s -w" -o server src/main.go \
  && upx --best server -o _upx_server \
  && mv -f _upx_server server

FROM scratch as runner
COPY --from=builder /usr/share/zoneinfo/Asia/Chongqing /etc/localtime
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /app/server /app/

CMD ["/app/server"]

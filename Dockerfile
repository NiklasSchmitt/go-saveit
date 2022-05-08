FROM golang:1.18.1-alpine AS builder
RUN apk add --no-cache --upgrade bash && apk add unzip wget
RUN wget https://github.com/NiklasSchmitt/go-saveit/archive/refs/heads/main.zip && unzip main.zip
WORKDIR go-saveit-main
RUN CGO_ENABLED=0 GOOS="linux" GOARCH="amd64" go build -ldflags="-w -s" -o /go-saveit

FROM scratch
COPY --from=builder /go-saveit /
CMD ["./go-saveit"]

FROM golang:1.18.1-buster AS builder
#RUN mkdir /build
RUN apt update && apt install -y unzip wget

RUN wget https://github.com/NiklasSchmitt/go-saveit/archive/refs/heads/main.zip && unzip main.zip -d /build
RUN export CGO_ENABLED=0
RUN cd /build/go-saveit-main/ && go build -o /build/go-saveit
RUN ls -alh
RUN ls -alh /

FROM alpine
RUN mkdir /app
RUN adduser -S -D -H -h /app appuser
USER appuser
RUN ls -alh
#ORKDIR /app
COPY --from=builder /build/go-saveit /app/go-saveit
RUN ls -alh /app
ENTRYPOINT ["/app/go-saveit"]

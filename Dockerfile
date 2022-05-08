FROM golang:1.18.1-buster AS builder
RUN mkdir /app

# Set the Current Working Directory inside the container
WORKDIR /app

ADD . /app

# Build the Go app
RUN go get -u github.com/NiklasSchmitt/go-saveit && go build -o app/go-saveit

ENTRYPOINT ["/app/go-saveit"]

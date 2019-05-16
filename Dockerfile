# Prepare builder for compile source code

FROM golang:latest as builder

WORKDIR $GOPATH

# Download source code
RUN go get -u github.com/schachmat/wego
WORKDIR $GOPATH/src/github.com/schachmat/wego

# Get dependencies
RUN go get -d -v ./...

# compile source code
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /go/bin/wego .

# Prepare target container

FROM alpine:latest

WORKDIR /usr/local/bin/
COPY --from=builder /go/bin/wego .
RUN chmod +x wego

entrypoint ["/usr/local/bin/wego"]

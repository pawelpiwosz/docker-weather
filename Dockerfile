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

FROM alpine:3.19.1

# For Travis build
ARG BUILD_DATE
ARG VCS_REF
ARG VER

LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.vcs-ref=$VCS_REF
LABEL org.label-schema.vcs-url="https://github.com/pawelpiwosz/docker-weather"
LABEL org.label-schema.name="docker-weather"
LABEL org.label-schema.description="Check weather"
LABEL org.label-schema.version=$VER


WORKDIR /usr/local/bin/
COPY --from=builder /go/bin/wego .
RUN chmod +x wego

ENTRYPOINT ["/usr/local/bin/wego"]

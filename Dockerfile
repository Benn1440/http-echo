# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# Stage 1: Build the Go application
FROM golang:latest AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

# No need to specify GOOS=linux for Windows
RUN CGO_ENABLED=0 go build -o /http-echo

# Stage 2: Final image with Alpine
FROM alpine:3.19

WORKDIR /

COPY --from=builder /http-echo /http-echo

EXPOSE 5678/tcp

ENV ECHO_TEXT="hello world"

ENTRYPOINT ["/http-echo"]


# FROM alpine:3.19 AS build

# SHELL ["/bin/bash", "-c"]

# WORKDIR /app

# COPY go.mod .
# COPY main.go .

# RUN go build -o /go-http-echo

# EXPOSE 5678/tcp

# ENV ECHO_TEXT="hello world"

# ENTRYPOINT ["/http-echo"]

# FROM gcr.io/distroless/static-debian12:nonroot as builder

# Set shell
# SHELL ["/bin/bash", "-c"]

# WORKDIR /build

# Copy only go.mod initially to leverage Docker cache
# COPY go.mod .
# COPY main.go .

# # Build the Go binary
# RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o http-echo .

# # Final stage
# FROM gcr.io/distroless/static-debian12:nonroot as default

# COPY --from=builder /build/http-echo /http-echo

# EXPOSE 8080

# ENV ECHO_TEXT="hello-world"

# ENTRYPOINT ["/http-echo"]


# FROM gcr.io/distroless/static-debian12:nonroot as default

# # TARGETOS and TARGETARCH are set automatically when --platform is provided.
# ARG TARGETOS
# ARG TARGETARCH
# ARG PRODUCT_VERSION
# ARG BIN_NAME

# LABEL name="http-echo" \
#       maintainer="HashiCorp Consul Team <consul@hashicorp.com>" \
#       vendor="HashiCorp" \
#       version=$PRODUCT_VERSION \
#       release=$PRODUCT_VERSION \
#       summary="A test webserver that echos a response. You know, for kids." 

# # COPY dist/$TARGETOS/$TARGETARCH/$BIN_NAME /
# COPY go.mod .
# COPY main.go .

# EXPOSE 8080

# ENV ECHO_TEXT="hello-world"

# ENTRYPOINT ["/http-echo"]

# FROM buildpack-deps:bookworm-scm AS build
# FROM golang:1.10

# # Set the Current Working Directory inside the container
# WORKDIR /app

# # Copy everything from the current directory to the PWD (Present Working Directory) inside the container
# COPY go.mod .
# COPY main.go .

# # Download all the dependencies
# RUN go get -d -v ./...

# # Install the package
# RUN go install -v ./...

# # This container exposes port 8080 to the outside world
# EXPOSE 5678/tcp

# # Run the executable
# ENV ECHO_TEXT="hello world"

# ENTRYPOINT ["/http-echo"]

# FROM alpine:3.19 AS build

# WORKDIR /app

# COPY go.mod .
# COPY main.go .

# RUN go build -o bin .

# EXPOSE 5678/tcp

# ENV ECHO_TEXT="hello-world"

# ENTRYPOINT ["/http-echo"]



# FROM gcr.io/distroless/static-debian12:nonroot as default

# # TARGETOS and TARGETARCH are set automatically when --platform is provided.
# ARG TARGETOS
# ARG TARGETARCH
# ARG PRODUCT_VERSION
# ARG BIN_NAME

# LABEL name="http-echo" \
#       maintainer="HashiCorp Consul Team <consul@hashicorp.com>" \
#       vendor="HashiCorp" \
#       version=$PRODUCT_VERSION \
#       release=$PRODUCT_VERSION \
#       summary="A test webserver that echos a response. You know, for kids." 

# COPY dist/$TARGETOS/$TARGETARCH/$BIN_NAME /

# EXPOSE 5678/tcp

# ENV ECHO_TEXT="hello-world"

# ENTRYPOINT ["/http-echo"]

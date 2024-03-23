# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0
# Stage 1: Build the Go application with a minimal image
FROM golang:alpine AS builder

# Working directory inside the container
WORKDIR /app

# Copy code into the container
COPY . .

# Build the http-echo server
RUN go build -o http-echo .

# stage for a lightweight image
FROM alpine

# working directory inside the container
WORKDIR /app

# Copy the built binary from the previous stage
COPY --from=builder /app/http-echo .

# Expose the port which the server listens on
EXPOSE 5678/tcp

# Environment variables
ENV ECHO_TEXT="hello-world" 

# Set the default command to run the server
ENTRYPOINT ["./http-echo"]

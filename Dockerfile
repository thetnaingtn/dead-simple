# Stage 1: Build stage
FROM golang:1.24-alpine AS builder

# Set working directory
WORKDIR /app

# Copy go mod and sum files
COPY go.mod go.sum* ./

# Download dependencies
RUN go mod download

# Copy source code
COPY . .

# Build the application for Linux
RUN CGO_ENABLED=0 GOOS=linux go build -a -o main .

# Stage 2: Runtime stage
FROM alpine:latest

WORKDIR /app

# Copy the binary from builder stage
COPY --from=builder /app/main .

# Expose port 8080 (you can change this based on your needs)
EXPOSE 8080

# Command to run the executable
CMD ["./main"]

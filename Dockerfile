# Use a minimal base image
FROM golang:1.18 as builder
WORKDIR /app
COPY ./src ./
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -o tank .

FROM alpine:latest
COPY --from=builder /app/tank /tank
ENTRYPOINT ["/tank"]

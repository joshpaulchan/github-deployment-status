# syntax=docker/dockerfile:1
FROM golang:1.16
WORKDIR /opt/app
COPY main.go ./
COPY go.mod ./
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

FROM alpine:latest  
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=0 /opt/app ./
CMD ["./main"]  

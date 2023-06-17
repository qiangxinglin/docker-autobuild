FROM golang:alpine AS builder
# https://tailscale.com/kb/1118/custom-derp-servers/
RUN go install tailscale.com/cmd/derper@main

FROM alpine:latest
COPY --from=builder /go/bin/derper /usr/local/bin
ENTRYPOINT ["derper"]

# FROM $TARGETARCH/alpine:edge as builder
# COPY p910nd /build
# RUN \
#   apk add --update gcc make build-base &&\
#   cd /build && make && chmod +x ./p910nd

FROM $TARGETARCH/alpine:edge
# WORKDIR /
# COPY --from=builder /build/p910nd /usr/sbin/
ENTRYPOINT ["/usr/sbin/p910nd"]

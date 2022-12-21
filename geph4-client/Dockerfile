# build geph4-client and gephgui-wry, fetch blobs
FROM rust:buster
RUN \
  apt update && apt install -y \
    gcc clang g++ zlib1g-dev libmpc-dev \
    libmpfr-dev libgmp-dev  build-essential && \
  git clone https://github.com/geph-official/geph4-client.git /geph4-client && \
  cd /geph4-client && cargo build --release && \
  mv /geph4-client/target/release/geph4-client /build && \
  chmod -R +x /build

# final image
FROM alpine:latest
COPY --from=0 /build/ /usr/bin
ENTRYPOINT  /usr/bin/geph4-client

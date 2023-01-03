# syntax = docker/dockerfile:experimental
# https://github.com/rust-lang/cargo/issues/8719

FROM rust:buster
RUN --security=insecure \
  mkdir -p /root/.cargo &&\
  chmod 777 /root/.cargo &&\
  mount -t tmpfs none /root/.cargo &&\
  apt update && apt install -y \
    gcc clang g++ zlib1g-dev libmpc-dev \
    libmpfr-dev libgmp-dev  build-essential && \
  git clone https://github.com/geph-official/geph4-client.git /geph4-client && \
  cd /geph4-client && cargo build --release &&\
  chmod u+x /geph4-client/target/release/geph4-client 

# final image
FROM debian:latest
COPY --from=0 /geph4-client/target/release/geph4-client /usr/bin/geph4-client
CMD  ["/usr/bin/geph4-client"]

FROM rust:buster
RUN \
  apt update && apt install -y \
    gcc clang g++ zlib1g-dev libmpc-dev \
    libmpfr-dev libgmp-dev  build-essential && \
  git clone https://github.com/geph-official/geph4-client.git /geph4-client && \
  cd /geph4-client && cargo build --release &&\
  chmod u+x /geph4-client/target/release/geph4-client 

# final image
FROM debian:latest

COPY --from=0 /geph4-client/target/release/geph4-client /usr/bin/geph4-client
COPY entrypoint.sh /

RUN \
  chmod u+x /entrypoint.sh &&\
  apt update && apt install -y ca-certificates jq &&\
  apt-get clean && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

EXPOSE 9809
EXPOSE 9909
EXPOSE 9910
EXPOSE 15353
VOLUME /config

# 1 means flag is present
ENV EXCLUDE_PRC=true
ENV STICKY_BRIDGES=false
ENV USE_BRIDGES=false
ENV USE_TCP=false

# empty means flag not present
ENV USERNAME="guest12345"
ENV PASSWORD="guest12345"
ENV EXIT_SERVER=""
ENV TCP_SHARD_COUNT=""
ENV TCP_SHARD_LIFETIME=""
ENV UDP_SHARD_COUNT=""
ENV UDP_SHARD_LIFETIME=""
ENV EXTRA_PARAMS=""

ENTRYPOINT ["bash", "/entrypoint.sh"]

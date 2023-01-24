FROM alpine:latest as builder

COPY i2pd /build

RUN apk update \
    && apk --no-cache --virtual build-dependendencies add \
     make gcc \g++ libtool zlib-dev boost-dev build-base \
      openssl-dev openssl miniupnpc-dev \
    && cd /build \
    && make USE_UPNP=yes \
    && strip i2pd 

# 2. Adding required libraries to run i2pd to ensure it will run.

FROM alpine:latest

ENV DEFAULT_ARGS=" --datadir=/config --reseed.verify=true --upnp.enabled=true --http.enabled=true --http.address=0.0.0.0 --httpproxy.enabled=true --httpproxy.address=0.0.0.0 --socksproxy.enabled=true --socksproxy.address=0.0.0.0 --sam.enabled=true --sam.address=0.0.0.0"

COPY --from=builder  /build/i2pd /usr/local/bin
COPY i2pd/contrib/certificates /config
COPY rootfs/ /

RUN \
  apk --no-cache add boost-filesystem boost-system \
    boost-program_options boost-date_time boost-thread \
    boost-iostreams openssl miniupnpc musl-utils libstdc++ &&\
  chmod a+x /entrypoint.sh &&\
  echo "export DATA_DIR=/config" >> /etc/profile 

VOLUME /config
EXPOSE 7070 4444 4447 7656 2827 7654 7650

CMD [ "/entrypoint.sh" ]
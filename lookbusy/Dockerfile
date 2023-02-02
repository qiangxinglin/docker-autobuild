FROM alpine:latest as builder

# build lookbusy
COPY ./lookbusy-1.4.tar.gz /
RUN tar -zxvf /lookbusy-1.4.tar.gz
RUN  apk add --update cmake gcc build-base openssl-dev curl-dev libxml2-dev
RUN cd lookbusy-1.4 && chmod +x ./configure &&\
    ./configure && make && chmod +x lookbusy
# build speedtest
COPY ./speedtest /speedtest
RUN cd speedtest &&\
    cmake -DCMAKE_BUILD_TYPE=Release &&\
    make && chmod +x SpeedTest

# move into /app for copy
RUN mkdir -p /app &&\
    mv /speedtest/SpeedTest /app/speedtest &&\
    mv /lookbusy-1.4/lookbusy /app

FROM alpine:latest
RUN apk add --update --no-cache gcc openssl libcurl libxml2
COPY rootfs/ /
COPY --from=builder /app /usr/bin/
ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
FROM alpine:latest as builder

# build lookbusy
COPY ./lookbusy-1.4.tar.gz /
RUN tar -zxvf /lookbusy-1.4.tar.gz
RUN  apk add --update cmake gcc build-base libcurl libssl libxml2
RUN cd lookbusy-1.4 && chmod +x ./configure &&\
    ./configure && make && chmod +x lookbusy
# build speedtest
COPY ./SpeedTest /speedr
RUN cd /SpeedTe
# move into /app for copy
RUN mkdir -p /app &&\
    mv /ping/build/fastping /app &&\
    mv /lookbusy-1.4/lookbusy /app

FROM alpine:latest
COPY rootfs/ /
COPY --from=builder /app /usr/bin/
ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
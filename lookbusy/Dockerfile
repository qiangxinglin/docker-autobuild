FROM alpine:latest as builder
COPY ./lookbusy-1.4.tar.gz /
RUN tar -zxvf /lookbusy-1.4.tar.gz
RUN  apk add --update make gcc build-base
RUN cd lookbusy-1.4 && chmod +x ./configure &&\
    ./configure && make && chmod +x lookbusy

FROM alpine:latest
RUN apk add --no-cache iputils
COPY rootfs/ /
COPY --from=builder /lookbusy-1.4/lookbusy /usr/bin/
ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
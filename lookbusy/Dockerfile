FROM alpine:latest as builder

# build lookbusy
COPY ./lookbusy-1.4.tar.gz /
RUN tar -zxvf /lookbusy-1.4.tar.gz
RUN  apk add --update cmake gcc build-base
RUN cd lookbusy-1.4 && chmod +x ./configure &&\
    ./configure && make && chmod +x lookbusy
# build fastping
COPY ./ping /ping
RUN cd /ping && mkdir build && cd build &&\
    sed -i 's/REQUEST_TIMEOUT 1000000/REQUEST_TIMEOUT 10000/g' ../src/ping.c &&\
    sed -i 's/REQUEST_INTERVAL 1000000/REQUEST_INTERVAL 10000/g' ../src/ping.c &&\
    cmake ../ -G "Unix Makefiles" && make &&\
    mv ./ping ./fastping && chmod +x fastping
# move into /app for copy
RUN mkdir -p /app &&\
    mv /ping/build/fastping /app &&\
    mv /lookbusy-1.4/lookbusy /app

FROM alpine:latest
COPY rootfs/ /
COPY --from=builder /app /usr/bin/
ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
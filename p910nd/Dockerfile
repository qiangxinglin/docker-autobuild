FROM debian:latest
RUN apt update && apt -y install g++ make
COPY p910nd /usr/src/p910nd
WORKDIR /usr/src/p910nd
RUN make

FROM alpine:latest
ENV PRINTER_DEVICE="/dev/usb/lp0"
ENV BIDIRECTIONAL=1
ENV DEBUG_INFO=0
VOLUME /dev
WORKDIR /

COPY entrypoint.sh /
COPY --from=0 /usr/src/p910nd/p910nd /usr/bin
ENTRYPOINT "/entrypoint.sh"

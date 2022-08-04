FROM debian:latest
ENV PRINTER_DEVICE="/dev/usb/lp0"
ENV BIDIRECTIONAL=1
ENV DEBUG_INFO=0
COPY entrypoint.sh /
WORKDIR /usr/src/p910nd

RUN apt update && apt -y install p910nd && apt clean

ENTRYPOINT ["/entrypoint.sh"]

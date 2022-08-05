FROM debian:latest
WORKDIR /
RUN apt update && apt -y install p910nd && apt clean
ENTRYPOINT ["/usr/sbin/p910nd"]

FROM debian:latest
WORKDIR /
RUN apt-get update && apt-get install -y p910nd && apt-get clean
ENTRYPOINT ["/usr/sbin/p910nd"]

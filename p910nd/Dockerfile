FROM debian:latest
COPY entrypoint.sh /
WORKDIR /
RUN apt update && apt -y install p910nd && apt clean
ENTRYPOINT ["/entrypoint.sh"]

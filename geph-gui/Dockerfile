FROM debian:latest
RUN \
  apt update && \
  apt install -y git jq nodejs npm libatk1.0-dev libglib2.0-dev libpango1.0-0 libsoup2.4 libgdk-pixbuf-2.0-0 && \
  cd / && git clone https://github.com/geph-official/gephgui-wry.git && \
  cd gephgui  && \
  bash build-linux.sh

FROM ghcr.io/linuxserver/baseimage-rdesktop-web:jammy

# global environment settings
ENV DEBIAN_FRONTEND="noninteractive" CUSTOM_PORT="8080"

COPY --from=0 /gephgui/dist/linux-unpacked/ /gephgui
COPY root/ /

VOLUME /root/.config

FROM rust:latest
RUN \
  apt update && \
  apt install -y 	libgtk-3-dev libappindicator3-dev libwebkit2gtk-4.0-dev libayatana-appindicator3-dev librsvg2-dev libssl-dev patchelf strace libpango1.0-dev  libgdk-pixbuf2.0-dev
  build-essential && \
  cd / && git clone https://github.com/geph-official/gephgui-wry.git && \
  cd /gephgui-wry  && \
  cargo build

FROM ghcr.io/linuxserver/baseimage-rdesktop-web:jammy

# global environment settings
ENV DEBIAN_FRONTEND="noninteractive" CUSTOM_PORT="8080"

COPY --from=0 /gephgui/dist/linux-unpacked/ /gephgui
COPY root/ /

VOLUME /root/.config

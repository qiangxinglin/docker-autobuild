FROM ghcr.io/linuxserver/baseimage-rdesktop-web:jammy

# global environment settings
ENV DEBIAN_FRONTEND="noninteractive" CUSTOM_PORT="8080"

RUN  \
  apt update && apt install -y curl flatpak && \
  curl $(curl https://geph.io/en/ | grep -Po "https:\/\/[^<]+?\.flatpak") > /geph.flatpak && \
  flatpak install -y /geph.flatpak && \
  apt-get clean && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

VOLUME /root/.config

# add local files
COPY root/ /
# build front end
FROM node:buster
RUN \
  git clone --recurse-submodules https://github.com/geph-official/gephgui-wry.git /gephgui-wry && \
  cd /gephgui-wry/gephgui && npm install && npm run build


# build geph4-client and gephgui-wry
FROM rust:buster
COPY --from=0 /gephgui-wry /gephgui-wry
RUN \
  apt update && apt install -y \
    libgtk-3-dev libappindicator3-dev libwebkit2gtk-4.0-dev \
    librsvg2-dev libssl-dev patchelf strace libpango1.0-dev  \
    libgdk-pixbuf2.0-dev gcc clang g++ zlib1g-dev libmpc-dev \
    libmpfr-dev libgmp-dev  build-essential && \
  git clone https://github.com/geph-official/geph4-client.git /geph4-client && \
  cd /geph4-client && cargo build --release && \
  cd /gephgui-wry && cargo build --release && \
  mkdir /build && \
  mv /geph4-client/target/release/geph4-client /build && \
  mv /gephgui-wry/target/release/gephgui-wry /build

# final image
FROM ghcr.io/linuxserver/baseimage-rdesktop-web:jammy
ENV DEBIAN_FRONTEND="noninteractive" CUSTOM_PORT="8080"
COPY --from=1 /build /app
COPY root/ /

VOLUME /root/.config

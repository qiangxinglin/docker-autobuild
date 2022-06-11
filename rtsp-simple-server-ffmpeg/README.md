<p align="center">
    <img src="https://github.com/aler9/rtsp-simple-server/raw/main/logo.png" alt="rtsp-simple-server">
</p>


![](https://img.shields.io/badge/ARCH-x86-9cf) ![](https://img.shields.io/badge/ARCH-x86_64-red) ![](https://img.shields.io/badge/ARCH-ARM_64-ff69b4) ![](https://img.shields.io/badge/ARCH-ARM_v7-yellow) ![](https://img.shields.io/badge/ARCH-ARM_v6-yellowgreen)

[![Test](https://github.com/aler9/rtsp-simple-server/workflows/test/badge.svg)](https://github.com/aler9/rtsp-simple-server/actions?query=workflow:test)
[![Lint](https://github.com/aler9/rtsp-simple-server/workflows/lint/badge.svg)](https://github.com/aler9/rtsp-simple-server/actions?query=workflow:lint)
[![CodeCov](https://codecov.io/gh/aler9/rtsp-simple-server/branch/main/graph/badge.svg)](https://codecov.io/gh/aler9/rtsp-simple-server/branch/main)
[![Release](https://img.shields.io/github/v/release/aler9/rtsp-simple-server)](https://github.com/aler9/rtsp-simple-server/releases)
[![Docker Hub](https://img.shields.io/badge/docker-aler9/rtsp--simple--server-blue)](https://hub.docker.com/r/aler9/rtsp-simple-server)
[![API Documentation](https://img.shields.io/badge/api-documentation-blue)](https://aler9.github.io/rtsp-simple-server)


> This image is buildt based on offical rtsp-simple-server image, with ffmpeg support.

_rtsp-simple-server_ is a ready-to-use and zero-dependency server and proxy that allows users to publish, read and proxy live video and audio streams through various protocols:

|protocol|description|publish|read|proxy|
|--------|-----------|-------|----|-----|
|RTSP|fastest way to publish and read streams|:heavy_check_mark:|:heavy_check_mark:|:heavy_check_mark:|
|RTMP|allows to interact with legacy software|:heavy_check_mark:|:heavy_check_mark:|:heavy_check_mark:|
|Low-Latency HLS|allows to embed streams into a web page|:x:|:heavy_check_mark:|:heavy_check_mark:|

Features:

* Publish live streams to the server
* Read live streams from the server
* Act as a proxy and serve streams from other servers or cameras, always or on-demand
* Each stream can have multiple video and audio tracks, encoded with any codec, including H264, H265, VP8, VP9, MPEG2, MP3, AAC, Opus, PCM, JPEG
* Streams are automatically converted from a protocol to another. For instance, it's possible to publish a stream with RTSP and read it with HLS
* Serve multiple streams at once in separate paths
* Authenticate users; use internal or external authentication
* Query and control the server through an HTTP API
* Read Prometheus-compatible metrics
* Redirect readers to other RTSP servers (load balancing)
* Run external commands when clients connect, disconnect, read or publish streams
* Reload the configuration without disconnecting existing clients (hot reloading)
* Compatible with Linux, Windows and macOS, does not require any dependency or interpreter, it's a single executable
## Docker

Download and launch the image:

```
docker run --rm -it --network=host justinhimself/rtsp-simple-server-ffmpeg
```

The `--network=host` flag is mandatory since Docker can change the source port of UDP packets for routing reasons, and this doesn't allow the server to find out the author of the packets. This issue can be avoided by disabling the UDP transport protocol:

```
docker run --rm -it -e RTSP_PROTOCOLS=tcp -p 8554:8554 -p 1935:1935 -p 8888:8888 justinhimself/rtsp-simple-server-ffmpeg
```

## Basic usage

1. Publish a stream. For instance, you can publish a video/audio file with _FFmpeg_:

   ```
   ffmpeg -re -stream_loop -1 -i file.ts -c copy -f rtsp rtsp://localhost:8554/mystream
   ```

   or _GStreamer_:

   ```
   gst-launch-1.0 rtspclientsink name=s location=rtsp://localhost:8554/mystream filesrc location=file.mp4 ! qtdemux name=d d.video_0 ! queue ! s.sink_0 d.audio_0 ! queue ! s.sink_1
   ```

   To publish from other hardware / software, take a look at the [Publish to the server](#publish-to-the-server) section.

2. Open the stream. For instance, you can open the stream with _VLC_:

   ```
   vlc rtsp://localhost:8554/mystream
   ```

   or _GStreamer_:

   ```
   gst-play-1.0 rtsp://localhost:8554/mystream
   ```

   or _FFmpeg_:

   ```
   ffmpeg -i rtsp://localhost:8554/mystream -c copy output.mp4
  
## Document

https://github.com/aler9/rtsp-simple-server#table-of-contents

<img src="logo.png" width="50%" alt="迷雾通 logo">

---

![](https://img.shields.io/badge/ARCH-x86-9cf)
![](https://img.shields.io/badge/ARCH-x86_64-red)
![](https://img.shields.io/badge/ARCH-ARM_64-ff69b4)
![](https://img.shields.io/badge/ARCH-ARM_v7-yellow)

## Description

This is a mutiarch iamge of geph4-client.

## Usage

Here's some instrction on how to run the container.

```
docker run --rm justinhimself/geph4-client connect --help
```

## Build locally

The Dockerfile is publically availiable at [justin-himself/docker-autobuild](https://github.com/justin-himself/docker-autobuild). Execute the followling command if you want to build a custom version of the image.

```bash
git clone https://github.com/justin-himself/docker-autobuild.git
cd docker-autobuild/gephgui
docker build \
  --no-cache \
  --pull \
  -t justin-himself/gephgui:latest .
```

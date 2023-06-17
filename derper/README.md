## derper

![](https://img.shields.io/badge/x86-9cf)
![](https://img.shields.io/badge/x86_64-red)
![](https://img.shields.io/badge/ARM_64-ff69b4)
![](https://img.shields.io/badge/ARM_v7-yellow)
![](https://img.shields.io/badge/ARM_v6-green)
![](https://img.shields.io/badge/PowerPC_64_le-blueviolet)
![](https://img.shields.io/badge/IBM_Z-blue)

This is a tailscale [derper](https://tailscale.com/kb/1118/custom-derp-servers/) alpine minimal image.

## Quick Start

Refer to the [offical document](https://pkg.go.dev/tailscale.com/cmd/derper), use it like you normal would.

```bash
docker run  \
  --name derper \
  -d qiangxinglin/derper
```


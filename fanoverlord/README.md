<p align="center">
    <img src="https://raw.githubusercontent.com/justin-himself/docker-autobuild/master/fanoverlord/icon.png" width="40%" height="40%" alt="FanOverlord">
</p>

# (Better) FanOverlord

![](https://img.shields.io/badge/ARCH-x86-9cf) ![](https://img.shields.io/badge/ARCH-x86_64-red) ![](https://img.shields.io/badge/ARCH-ARM_64-ff69b4) ![](https://img.shields.io/badge/ARCH-ARM_v7-yellow) ![](https://img.shields.io/badge/ARCH-ARM_v6-green) ![](https://img.shields.io/badge/ARCH-PowerPC_64_le-blueviolet) ![](https://img.shields.io/badge/ARCH-IBM_Z-blue) 

This is a Docker container that uses IPMI to monitor and control the fans on a Dell EMC Poweredge server through the iDRAC using raw commands.

This script will read the CPU temp sensor repetitively and then adjust the fan speed according to a user-defined function.

The script is originated from orlikoski's project [fanoverlord](https://github.com/orlikoski/fanoverlord). 


### Configure iDRAC
 - [Set IP Address for iDRAC and ensure docker can communicate with it](https://docs.extrahop.com/current/configure-i-drac/)
 - [Enable IPMI in the iDRAC ](http://www.fucking-it.com/articles/dell-idrac/214-dell-idrac-configure-ipmi)

### Choose Your TEMP-SPEED Function

To make your fan speed adjustment as smooth as possible, you should choose a function that maps the relationship between CPU temperature and fan speed. The function is expected to have these features:

- Continous                     -       So the transition is smooth
- Monotonically increasing      -       So the temperature always converages

The default function is  <img src="https://user-images.githubusercontent.com/73123028/174479239-71d1a8d3-6518-4114-8d0f-60566024f360.png" width="20%" height="20%">, where s is fan speed and t is temperature.   
This function works well when temperature is between 30 degrees and 60 degrees, which provides relatively low power consumption in this range.

<p align="center">
    <img src="https://user-images.githubusercontent.com/73123028/174478859-e08aa5e2-9161-47b4-9039-cc66f239d4ae.png" width="40%" height="40%">
</p>

### Pull the image and Start the container

To pull the image:

```
docker pull https://hub.docker.com/r/justinhimself/fanoverlord
```

To start the container:

```
docker run \
    --name fanoverlord \
    --restart always \
    -e CPU_NUM = 2 \
    -e IPMI_HOST = "192.168.0.120" \
    -e IPMI_USER = "root" \
    -e IPMI_PW = "calvin"
    -e SPEED_FUNC = "exp(0.075 * t) - 0.01 * t**2 + 10" \
    -d justinhimself/fanoverlord
```



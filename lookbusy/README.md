## LookBusy

![](https://img.shields.io/badge/x86-9cf)
![](https://img.shields.io/badge/x86_64-red)
![](https://img.shields.io/badge/ARM_64-ff69b4)
![](https://img.shields.io/badge/ARM_v7-yellow)
![](https://img.shields.io/badge/ARM_v6-green)
![](https://img.shields.io/badge/PowerPC_64_le-blueviolet)
![](https://img.shields.io/badge/IBM_Z-blue)

This the docker image for lookbusy.  
这个是 Lookbusy Docker Image, 这个 Image 包含专门针对 Oralce 的一键部署脚本, 并可以自动达成 10% 的网络占用 (通过每秒 ping 两次 1.1.1.1)

Lookbusy is a tool for making systems busy. It uses relatively simple techniques to generate CPU activity, memory and disk utilization and traffic.

### Why look busy

https://docs.oracle.com/en-us/iaas/Content/FreeTier/freetier_topic-Always_Free_Resources.htm

![Oralce Nonsense](https://raw.githubusercontent.com/justin-himself/docker-autobuild/master/lookbusy/oracle_nonsense.png)

## Quick Start

**For Oracle**

If you are bypassing Oracle policy stated above, simply execute:

```bash
docker run  \
  --name lookbusy \
  -e IS_ORACLE=true \
  --restart always \
  -d justinhimself/lookbusy
```

The script will automate everything for you, including:

- Keep CPU and Network busy
- Keep Memory busy for ARM Instance

**Normal use**

IF you just want to use the program, just use it like normal.

```bash
docker run  \
  --name lookbusy \
  -d justinhimself/lookbusy -h
```

## Demo

**Before Lookbusy**

**After Lookbusy**

## Details

**How lookbusy works?**

lookbusy generates synthetic CPU, memory and disk access loads on a host. CPU
load is induced by simple arithmetic looping (with as little memory bandwidth
consumption as feasible) alternating with periods of sleeping in an attempt to
generate the degree of utilization selected. Memory load is induced by
allocating a buffer of a controllable size, then steadily stirring it to keep
the pages active from the VM standpoint. Disk load is induced through
creation of one or more files, and copying blocks of it between two moving
positions.

**How network load works?**

The script will ping 1.1.1.1 every 500ms to ensure 10% network load.

**If CPU util is already 10%, will running is program cost extra?**

No.

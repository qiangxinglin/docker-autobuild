## LookBusy

This the docker image for lookbusy.

Lookbusy is a tool for making systems busy. It uses relatively simple techniques to generate CPU activity, memory and disk utilization and traffic.

### Why look busy

> https://docs.oracle.com/en-us/iaas/Content/FreeTier/freetier_topic-Always_Free_Resources.htm

Reclamation of Idle Compute Instances

Idle Always Free compute instances may be reclaimed by Oracle. Oracle will deem virtual machine and bare metal compute instances as idle if, during a 7-day period, the following are true:

CPU utilization for the 95th percentile is less than 10%
Network utilization is less than 10%
Memory utilization is less than 10% (applies to A1 shapes only)

## Quick Start

> For Oracle

If you are bypassing Oracle policy stated above, simply execute:

```bash
docker run  \
  --name keepbusy \
  -e IS_ORACLE=true \
  -d justinhimself/keepbusy
```

The container will take care _ALL_ of it for you, including network.

> For not oracle

IF you just want to use the program, just use it like normal.

```bash
docker run  \
  --name keepbusy \
  -d justinhimself/keepbusy -h
```

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

No. Same goes for memory.

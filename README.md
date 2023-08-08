# NetVueScript

## SD card
The SD card is mounted as 
/dev/mmcblk0 on /mnt/TF type vfat (rw,noatime,nodiratime,fmask=0022,dmask=0022,codepage=cp437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro)

It appears the **camera sends the state of the SD Card (mounted or not) to the app** somehow

## Log files
tail -f /var/run/nvc/log-logger_roll.log

## Attempt to fix the issue SDcard
/bin/sh /mnt/mtd/netvue/firmware/bin/loader
Removing some lock file
rm /var/run/nvc/pid-loader.pid

Didn't do the trick, but worse now app and cam would no longer communicate!!

## Device ID
2041503611705259

in practice to make the cam recognized by Netvue infrastructure, in the app
I said during Scan QR code sequence, the id was:
2314473851502382

## App return ID 
It doesn't match the real ID but at leat the app kind of works
2314 4738 5150 2382

### Trace app
2023-07-30 10:28:03.339  8315-27644 ConnectRouterTask       com.netviewtech  onDeviceFound.236 [Broadcast-recv-1690705628076]: device: 2314473851502382, 192.168.1.29:5555 

## Firmware version
So far 1735
Wants to ugrage to 1803 but since the app thinks it's Orb Home cam I don't think it is a good idea.

## Reading Netvue the SD/TF files on PC

[see file converter](https://support.netvue.com/hc/en-us/articles/360002581858-How-can-I-read-the-files-recorded-on-SD-TF-card-)

## Mountind SD card with mdev (udev equivalent)

Read [Automatically mount removable media](http://www.armadeus.org/wiki/index.php?title=Automatically_mount_removable_media)

## All about **mdev**
[Busybox mdev explanation and config](https://git.busybox.net/busybox/tree/docs/mdev.txt?h=1_18_stable)

## CPU info
~ # cat /proc/cpuinfo  
Processor       : ARMv6-compatible processor rev 7 (v6l)  
BogoMIPS        : 597.60  
Features        : swp half fastmult vfp edsp java tls  
CPU implementer : 0x41  
CPU architecture: 7  
CPU variant     : 0x0  
CPU part        : 0xb76  
CPU revision    : 7  
  
Hardware        : Goke IPC Board  
Revision        : 0000  
Serial          : 0000000000000000  

## Finding out open Ports on the camera

From a different machine **nmap -p- 192.168.1.29**


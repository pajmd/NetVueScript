# NetVueScript

## BusyBox
The Netvue Webcam run BusyBox instead of a full fledge linux system.
[Here](https://wiki.beyondlogic.org/index.php?title=Cross_Compiling_BusyBox_for_ARM) is an interesting article about installing BusyBox on a system.

## Booting up

first script run is **/etc/init.d/rcS**

## SD card
The SD card is mounted as 
/dev/mmcblk0 on /mnt/TF type vfat (rw,noatime,nodiratime,fmask=0022,dmask=0022,codepage=cp437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro)

It appears the **camera sends the state of the SD Card (mounted or not) to the app** somehow

### Monitoring the SDCard mount

Added in  /var/spool/cron/crontabs -> /mnt/mtd/config/crontabs 
a line to run every 15 minutes  netvue_report.sh  

See:
```
crontab -e

1 3 * * * /mnt/mtd/netvue/firmware/bin/upgrade_check.sh
*/15 * * * * /root/netvue_report_sh

```
I am removing the line suppose to update the cam tous les jours at 3AM.  
Anyway **/mnt/mtd/netvue/firmware/bin/upgrade_check.sh** doesn't exist.

If /dev/mmcblk0 is no longer mounted the script sends a message to WDMyCloud netvue_status.sh with logs it in pjmd2/netvue.log

Details can be found [here](https://github.com/pajmd/NetVueScript/tree/main/WDMyCLoud).

### Disk space consumption
 It eats up ~~about 4GB / hour~~ between 16-20GB a day from a total of 119 GB.  
 In a little less than ~~5~~ 7-6 days the SD card should be maxed out (today 08/09 then 13/09).

## Transferring video files from the camera to WDMyCloud

 Since **curl** doesn't exist in BusyBox and **wget** can not upload files, I decided
 to use **netcat aka nc** and **dd** to copy over viseo files to the **NAS**

 ### The set up
 On the client side (the cam) I wrote the **xfr.sh** script that will be launched every 30sec
 via **cron**. **xfr.sh** finds the latest file to be transferred, makes a tar ball, **dd**s it and sends it
 to the NAS with **nc**.
 
 On the server side (the NAS) I wrote **netvue_recording_rcvr_script**, an **nc** listener that 
 receives the tar ball **dd**s it out and untars it.

The cron job needs to be run every 30s, knowing that taring and sending the files takes about
30sec and video files are created pretty much every minute. The size of the files is 16MB.

```
* * * * * /root/xfr.sh
* * * * * sleep 30; /root/xfr.sh 
```

## Manual formatting
```
mkfs.vfat -v /dev/mmcblk0
```
To format and seems to cause a reboot (benefic?)

## To be noted
fdisk returns a questionable number of cylinders  
~ # fdisk /dev/mmcblk0

The number of cylinders for this disk is set to 3907584.  
There is nothing wrong with that, but this is larger than 1024,  
and could in certain setups cause problems with:  
1) software that runs at boot time (e.g., old versions of LILO)  
2) booting and partitioning software from other OSs  
   (e.g., DOS FDISK, OS/2 FDISK)
   
```
~ # df  
Filesystem           1K-blocks      Used Available Use% Mounted on  
/dev/root                 3072      1864      1208  61% /  
tmpfs                    30084         0     30084   0% /dev  
tmpfs                    30084         0     30084   0% /tmp  
/dev/mtdblock4           11328      6372      4956  56% /mnt/mtd
tmpfs                    30084         0     30084   0% /tmp
tmpfs                    30084        68     30016   0% /var/run
tmpfs                    10240         0     10240   0% /var/run/cloud_storage
/dev/mmcblk0         124981648 124878672    102976 100% /mnt/TF
~ # df -h
Filesystem                Size      Used Available Use% Mounted on
/dev/root                 3.0M      1.8M      1.2M  61% /
tmpfs                    29.4M         0     29.4M   0% /dev
tmpfs                    29.4M         0     29.4M   0% /tmp
/dev/mtdblock4           11.1M      6.2M      4.8M  56% /mnt/mtd
tmpfs                    29.4M         0     29.4M   0% /tmp
tmpfs                    29.4M     68.0K     29.3M   0% /var/run
tmpfs                    10.0M         0     10.0M   0% /var/run/cloud_storage
/dev/mmcblk0            119.2G    119.1G    100.6M 100% /mnt/TF
~ # mount
rootfs on / type rootfs (rw)
/dev/root on / type jffs2 (rw,relatime)
proc on /proc type proc (rw,relatime)
tmpfs on /dev type tmpfs (rw,relatime)
tmpfs on /tmp type tmpfs (rw,relatime)
sysfs on /sys type sysfs (rw,relatime)
devpts on /dev/pts type devpts (rw,relatime,mode=600,ptmxmode=000)
/dev/mtdblock4 on /mnt/mtd type jffs2 (rw,relatime)
tmpfs on /tmp type tmpfs (rw,relatime)
tmpfs on /var/run type tmpfs (rw,relatime)
tmpfs on /var/run/cloud_storage type tmpfs (rw,noatime,nodiratime,size=10240k)
/dev/mmcblk0 on /mnt/TF type vfat (rw,relatime,fmask=0022,dmask=0022,codepage=cp437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro)
```

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

## Config files

See /mnt/mtd/netvue/firmware/config/v4  
I saved backup copies there just in case.


## Files of interest on the phone

/storage/emulated/0/Android/data/com.netviewtech/files/.config/udid
/storage/emulated/0/Android/data/com.netviewtech/files/log, log.udid:2d824eb78c13153251a7232e608bd11c



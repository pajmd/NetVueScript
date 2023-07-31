# NetVueScript

## SD card
The SD card is mounted as 
/dev/mmcblk0 on /mnt/TF type vfat (rw,noatime,nodiratime,fmask=0022,dmask=0022,codepage=cp437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro)

## Log files
tail -f /var/run/nvc/log-logger_roll.log

## Attempt to fix the issue SDcard
/bin/sh /mnt/mtd/netvue/firmware/bin/loader
Removing some lock file
rm /var/run/nvc/pid-loader.pid

Didn't do the trick, but not app and cam would no longer communicate!!

## Device ID
2041503611705259

## App return ID 
It doesn't match the real ID but at leat the app kind of works
2314 4738 5150 2382

## Firmware version
So far 1735
Wants to ugrage to 1803 but since the app thinks it's Orb Home cam I don't think it is a good idea.

##Reading the SD/TF files on PC

[see file converter](https://support.netvue.com/hc/en-us/articles/360002581858-How-can-I-read-the-files-recorded-on-SD-TF-card-)

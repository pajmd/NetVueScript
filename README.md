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

Didn't do the trick


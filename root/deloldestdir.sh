#!/bin/sh

#pct=$(df /dev/mmcblk0 | grep mmcblk0 | awk '{ print $5}')
pct=$(echo $(df /dev/mmcblk0 | grep mmcblk0 | awk '{ print $5}') | cut -d"%" -f 1)
if [[ ! -z "$pct" ]]; then
    if [ $pct -ge 99 ]; then
       for i in $(ls -lC1 /mnt/TF/nvt3/ | head -n 2)
       do
         echo "deleting "$i
         rm /mnt/TF/nvt3/$i/*
       done
    fi
fi

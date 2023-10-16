#!/bin/bash

days=1
if [ "$1" != "" ]
then
 days=$1
fi

# find /shares/Public/NETVUE_CAM/*  -mtime -${days} -type d -print -exec bash -c "ls -l \"{}\" | wc -l" \;
find /shares/Public/NETVUE_CAM/*  -mtime -${days} -type d -print -exec bash -c "/home/pjmd2/dir_count_date.sh \"{}\"" \;

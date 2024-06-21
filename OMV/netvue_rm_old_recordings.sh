#!/bin/bash

# Run as cron jobs every day 8AM (keep 14 days of recordings)
# 0 8 * * * /home/pjmd/netvue/netvue_rm_old_recordings.sh

find /public/NETVUE_CAM -maxdepth 1 -type d -mtime +14 -exec rm -rf {} \;

# An alternative could be as follow but "print0" is very important to prevent
# misinterpretation
# find /public/NETVUE_CAM -type d -mtime +0 -print0 | xargs -0 ls -ld

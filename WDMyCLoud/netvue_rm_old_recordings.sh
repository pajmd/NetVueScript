#!/bin/bash

# Run as cron jobs every day 8AM (keep 14 days of recordings)
# 0 8 * * * /home/pjmd2/netvue_rm_old_recordings.sh

find /shares/Public/NETVUE_CAM -type d -mtime +14 -exec rm -rf {} \;

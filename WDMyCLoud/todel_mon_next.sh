#!/bin/bash

# looking for netvue_recording_rcvr_script with no kids and kill them
ppids=$(ps -ef | grep netvue_recording_rcvr_script | grep -v grep | awk '{print $2}')
for ppid in $ppids; 
do 
  echo $ppid; 
  pids=$(ps -ef | grep $ppid | grep -v recording | grep -v grep | awk '{print $2}'); 
  echo $pids; 
  if [ "$pids" = "" ]; then
    echo "Killing netvue_recording_rcvr_script $ppid" >> /home/pjmd2/bounced.log
    kill $ppid
  fi
done

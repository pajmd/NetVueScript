#!/bin/bash

now=$(date +'%s')
for pt in $(ps -ef | grep "nc -l -p 855" | grep -v grep | awk '{print $2";"$3";"$5";"$11}');
do
  t=$(echo $pt | cut -d";" -f3)
  pid=$(echo $pt | cut -d";" -f1)
  ppid=$(echo $pt | cut -d";" -f2)
  port=$(echo $pt | cut -d";" -f4)
  start_ts=$(date +'%s' -d$t)
  let run_ts=$now-$start_ts
  echo "runtime: ${run_ts}"
  if [ $run_ts -ge 300 ]; then
    echo "bounce rcvr? ${ppid}"
    # TODO restart proper service
    state=$(netstat -at | grep 8556 | grep -v grep | awk '{print $6}')
    echo $state;
    if [ "$state" = "ESTABLISHED" ]; then
      echo "Kill and bounce ${ppid} - ${port}"
      if [ $port -eq 8556 ]; then
        service="netvue_recording_rcvr_service"
      elif  [ $port -eq 8557 ]; then
        service="netvue_recording_rcvr_service2"
      fi
      echo "Now ${now} ${ppid} is stuck since ${start_ts} bounce it" >> /home/pjmd2/bounced.log
      echo "restart service ${service} restart"
      kill -9 $ppid
      service $service restart
    else
      echo "${ppid} - ${port} are in ${state} state, all good"
    fi
  fi
done

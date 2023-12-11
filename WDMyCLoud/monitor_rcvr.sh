#!/bin/bash

now=$(date +'%s')
for pt in $(ps -ef | grep "dd bs" | grep -v grep | awk '{print $2";"$3";"$5}');
do
  t=$(echo $pt | cut -d";" -f3)
  pid=$(echo $pt | cut -d";" -f1)
  ppid=$(echo $pt | cut -d";" -f2)
  start_ts=$(date +'%s' -d$t)
  let run_ts=$now-$start_ts
  echo "runtime: ${run_ts}"
  if [ $run_ts -ge 300 ]; then
    echo "bounce rcvr ${ppid}"
  fi
done

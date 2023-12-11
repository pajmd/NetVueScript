#!/bin/bash

now=$(date +'%s')
for t in $(ps -ef | grep "dd bs" | grep -v grep | awk '{print $5}');
do
  start_ts=$(date +'%s' -d$t)
  let run_ts=$now-$start_ts
  echo "runtime: ${run_ts}"
  if [ $run_ts -ge 300 ]; then
    echo "bounce rcvr it"
  fi
done

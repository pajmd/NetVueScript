#!/bin/bash +xv

now=$(date +'%s')
ports=("8556" "8557")

for port in ${ports[@]};
do
   echo $port;
   pids=$(netstat -atp | grep $port | grep -v grep | grep ESTABLISHED | awk '{print $ 7}' | awk -F/ '{print $1}')
   echo "Pids: $pids"
   if  [ "$pids" != "" ]; then
      for pid in $pids;
      do
         pt=$(ps -ef | grep "nc -l -p $port" | grep $pid | grep -v grep | awk '{print $2";"$3";"$5";"$11}')
         echo $pt
         t=$(echo $pt | cut -d";" -f3)
         ppid=$(echo $pt | cut -d";" -f2)
         start_ts=$(date +'%s' -d$t)
         let run_ts=$now-$start_ts
         echo "runtime: ${run_ts}"
         if [ $run_ts -ge 300 ]; then
            echo "$(date) - now ${now} pid: ${pid} ppid: ${ppid} port: ${port} is stuck since ${start_ts} bounce it" >> /home/pjmd2/bounced.log
            if [ $ppid -eq 1 ]; then
              echo "Owner is ${ppid} system kill: $pid" >> /home/pjmd2/bounced.log
              kill -9 $pid
            else
              service="netvue_recording_rcvr_service1"
              if [ $port = "8557" ]; then
                 service="netvue_recording_rcvr_service2"
              fi
              echo "Running: service ${service} restart" >> /home/pjmd2/bounced.log
              kill -9 $ppid
              sleep 2
              service $service start
            fi
         fi
      done
   fi
done

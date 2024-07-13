#/bin/sh

# runs every 30sec
last_xfer_log=/root/last_xfer.log
port_log=/root/port.log
IP=192.168.1.33
# IP=192.168.1.79

last_xfer=""
if [ -e "${last_xfer_log}" ]; then
  last_xfer=$(cat ${last_xfer_log})
fi

# port_num=8556
# if [ -e "${port_log}" ]; then
#    port_num=$(cat ${port_log})
# fi
# echo $((port_num == 8556 ? 8557 : 8556)) > ${port_log}

# what port is free
port=$(ps -ef | grep "nc " | grep 8557)
if [ -z "$port" ]
then
   port_num=8557
else
   port=$(ps -ef | grep "nc " | grep 8556)
   if [ -z "$port" ]
   then
      port_num=8556
   else
      # Just until a port is free
      echo "$(date) Both ports are busy" > ${port_log}
      exit 0
   fi
fi

port_num=8558
echo "$(date) $port_num" > ${port_log}

# Get the latest recording from the latest folder
cd /mnt/TF/nvt3
latest_folder=$(ls -dtrc1 */ | tail -1)
latest_recording=$(ls -trc1 $latest_folder | tail -1)

if [ "${latest_recording}" != "${last_xfer}" ]; then
  echo "${latest_recording}" > ${last_xfer_log}
  # echo "${latest_folder}${lastet_recording}" > recording_name.log
  tar cvf payload_$port_num "${latest_folder}${latest_recording}"
#  dd bs=16M if=payload_$port_num  | nc 192.168.1.91 $port_num
  echo "dd bs=16M if=payload_$port_num  | nc $IP $port_num"
  dd bs=16M if=payload_$port_num  | nc $IP $port_num
  rm payload_$port_num
fi

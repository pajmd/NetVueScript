#/bin/sh

# runs every 30sec
last_xfer_log=/root/last_xfer.log
port_log=/root/port.log

last_xfer=""
if [ -e "${last_xfer_log}" ]; then
  last_xfer=$(cat ${last_xfer_log})
fi

port_num=8556
if [ -e "${port_log}" ]; then
  port_num=$(cat ${port_log})
fi
echo $((port_num == 8556 ? 8557 : 8556)) > ${port_log}
  
# Get the latest recording from the latest folder
cd /mnt/TF/nvt3
latest_folder=$(ls -dtrc1 */ | tail -1)
latest_recording=$(ls -trc1 $latest_folder | tail -1)

if [ "${latest_recording}" != "${last_xfer}" ]; then
  echo "${latest_recording}" > ${last_xfer_log}
  # echo "${latest_folder}${lastet_recording}" > recording_name.log
  tar cvf payload_$port_num "${latest_folder}${latest_recording}"
  dd bs=16M if=payload_$port_num  | nc 192.168.1.91 $port_num
  rm payload_$port_num
fi



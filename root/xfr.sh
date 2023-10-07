#/bin/sh

# runs every 30sec
last_xfer_log=last_xfer.log

last_xfer=""
if [ -e "${last_xfer_log}" ]; then
  last_xfer=$(cat ${last_xfer_log})
fi
  
# Get the latest recording from the latest folder
cd /mnt/TF/nvt3
latest_folder=$(ls -dtrc1 */ | tail -1)
latest_recording=$(ls -trc1 $latest_folder | tail -1)

if [ "${latest_recording}" != "${last_xfer}" ]; then
  # echo "${latest_folder}${lastet_recording}" > recording_name.log
  tar cvf payload "${latest_folder}${latest_recording}"
  dd bs=16M if=payload  | nc 192.168.1.91 8556
  echo "${latest_recording}" > ${last_xfer_log}
fi



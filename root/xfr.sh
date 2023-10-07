#/bin/sh

# runs every 30sec

last_xfer=""
if [ -f last_xfer.log]; then
  last_xfer=$(cat last_xfer.log)
fi
  
# Get the latest recording from the latest folder
cd /mnt/TF/nvt3
latest_folder=$(ls -dtrc1 */ | tail -1)
ls -trc1 $latest_folder | tail -1

# TODO how do I transfer the folder/file name
if [ "${lastet_recording} != "${last_xfer}"]; then
  dd bs=16M if=${latest_folder}/${lastet_recording}  | nc 192.168.1.91 8556
fi


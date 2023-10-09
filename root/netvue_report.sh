
#
# Running on Netvue camera. 
# It is periodically launched from the cronatb
#
reformat=0
df -h | grep mmcblk0 > /dev/null
if [ $? = 1 ]; then
# msg=$(date)" mmcblk0 not mounted"
msg="mmcblk0 not mounted"
reformat=1
# echo $msg | nc 192.168.1.91 8888
else
# msg=$(date)" mmcblk0 still mounted"
msg="mmcblk0 still mounted"
# echo $msg | nc 192.168.1.91 8888
fi
upt=$(uptime)
mnt=$(df | grep mmcblk0 | grep -v grep)
echo $msg" - "$mnt" - "$upt | nc 192.168.1.91 8888

if [ $reformat -eq 1 ]; then
  # manual mount
  mount -t vfat /dev/mmcblk0 /mnt/TF
  #reformat, it is supposed to rebot automatically after that
  mkfs.vfat -v /dev/mmcblk0
fi


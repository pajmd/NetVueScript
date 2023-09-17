
#
# Running on Netvue camera. 
# It is periodically launched from the cronatb
#
df -h | grep mmcblk0 > /dev/null
if [ $? = 1 ]; then
# msg=$(date)" mmcblk0 not mounted"
msg="mmcblk0 not mounted"
# echo $msg | nc 192.168.1.91 8888
else
# msg=$(date)" mmcblk0 still mounted"
msg="mmcblk0 still mounted"
# echo $msg | nc 192.168.1.91 8888
fi
upt=$(uptime)
mnt=$(df | grep mmcblk0 | grep -v grep)
echo $msg" - "$mnt" - "$upt | nc 192.168.1.91 8888


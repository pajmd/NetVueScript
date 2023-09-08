
df -h | grep mmcblk0 > /dev/null
if [ $? = 1 ]; then
msg=$(date)" not mounted"
echo $msg | nc 192.168.1.91 8888
fi

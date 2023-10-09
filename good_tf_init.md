## Auto Mount SD Card

When the cam firmware detects the TF card and all goes well it shows in **/var/run/nvc/log-logger_roll.log** as:

[main] 1696842131407 I nv/main.c(220):[main] - nv_tfcard_manager_service_start
[main] 1696842131462 W nv/common/service/tfcard_service.c(111):[tf_detect] - tfcard found
[main] 1696842131463 I nv/common/service/tfcard_service.c(287):[tf_main] - mmc error count: 1
[main] 1696842131464 I serviced/emlib/signal0.c(72):[tf_main] - sigqueue mmc_check_start_1 success
[main] 1696842131465 I nv/common/service/tfcard_service.c(212):[tf_main] - found:true user_format:false stat:none->found
[main] 1696842131468 I serviced/extlib/path.c(191):[tf_main] - mkdir '/tmp/TF' success
[main] 1696842131479 I serviced/emlib/fs.c(115):[tf_main] - mount /dev/mmcblk0 -> /tmp/TF success
[main] 1696842131615 I serviced/emlib/fs.c(138):[tf_main] - umount /tmp/TF success
[main] 1696842131661 I serviced/emlib/fs.c(115):[tf_main] - mount /dev/mmcblk0 -> /tmp/TF success
[main] 1696842131663 I serviced/extlib/path.c(191):[tf_main] - mkdir '/tmp/TF/nvt3' success
[main] 1696842131774 I serviced/emlib/fs.c(138):[tf_main] - umount /tmp/TF success
[main] 1696842131794 I serviced/emlib/fs.c(115):[tf_main] - mount /dev/mmcblk0 -> /mnt/TF success
[main] 1696842131819 I nv/common/utils/tfcard_utils.c(116):[tf_main] - /dev/mmcblk0 prepare and mount success
[main] 1696842131819 I nv/common/utils/tfcard_utils.c(117):[tf_main] - mount success
[main] 1696842131890 I nv/common/service/tfcard_service.c(242):[tf_main] - nv_tfcard_manager_mediafs_sync start
[main] 1696842131891 I nv/base/mediafs/mediafs.c(91):[tf_main] - mediafs open /mnt/TF /mnt/TF/nvt3 start at 16860
[main] 1696842148249 I nv/base/mediafs/mediafs.c(100):[tf_main] - mediafs open /mnt/TF /mnt/TF/nvt3 complete at 33466 takes 16606
[main] 1696842148255 I nv/base/mediafs/mediafs.c(101):[tf_main] - open /mnt/TF/nvt3 success  total 127981207552  media 32768  other 0  available 127981174784  cnt 0
[main] 1696842148256 I nv/common/recording/local_recording.c(46):[tf_main] - nv_local_recording_service_resume

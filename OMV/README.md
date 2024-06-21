# Porting the recording scripts from WDMycloud to OMV

## Scripts
Located in In /home/pjmd/netvue
- netvue_recording_rcvr_script1
- netvue_recording_rcvr_script2
- netvue_recording_rcvr_service1.service
- netvue_recording_rcvr_service2.service
- netvue_status_script
- netvue_status_service.service

## Creating service in SYSTEMD
[Quick tuto](https://medium.com/@benmorel/creating-a-linux-service-with-systemd-611b5c8b91d6)

In /etc/systemd/system I created sym links:
* sudo ln -s /home/pjmd/netvue/netvue_recording_rcvr_service1.service netvue_recording_rcvr_service1.service
* sudo ln -s /home/pjmd/netvue/netvue_recording_rcvr_service2.service netvue_recording_rcvr_service2.service
* sudo ln -s /home/pjmd/netvue/netvue_status_service.service netvue_status_service.service

## Starting the services
In /home/pjmd/netvue
```
sudo systemctl start netvue_recording_rcvr_service1
sudo systemctl start netvue_recording_rcvr_service2
sudo systemctl status netvue_status_service.service
```

## Cron jobs

**monitor_rcvr.sh** is a cron job whose purpose is to monitor the recordings services in case they get stuck.

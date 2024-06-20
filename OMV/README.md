# Porting the recording scripts from WDMycloud to OMV

## Scripts
- netvue_recording_rcvr_script1
- netvue_recording_rcvr_script2
- netvue_recording_rcvr_service1.service
- netvue_recording_rcvr_service2.service

## Creating service in SYSTEMD
[Quick tuto](https://medium.com/@benmorel/creating-a-linux-service-with-systemd-611b5c8b91d6)

In /etc/systemd/system I created sym links:
* sudo ln -s /home/pjmd/netvue/netvue_recording_rcvr_service1.service netvue_recording_rcvr_service1.service
* sudo ln -s /home/pjmd/netvue/netvue_recording_rcvr_service2.service netvue_recording_rcvr_service2.service

## Starting the services
In /home/pjmd/netvue
```
sudo systemctl start netvue_recording_rcvr_service1
sudo systemctl start netvue_recording_rcvr_service2
```

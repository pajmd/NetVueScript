# WDMyCloud

I am using the nas as a server.

## users
I used users **root and pjmd2** (sshd allowed users) to set up the monitoring of the camera.

## WDMyCloud overview
WDMyCloud is a **System V init** system so as far as I understand even though there are **systemd unit files**
in /etc/systemd/system, only service files in /etc/init.d are being used by the system.

## Monitoring service
I created a service file **/home/pjmd2/netvue_status_service** that I linked in /etc/init.d that hopefully should
be executed when WDMyCloud boot up and that I can manage with:
```
service netvue_status_service [start/stop/status]
```

## Script launch by the service netvue_status_service
The service runs **netvue_status_script** located in /home/pjmd2 which just loops for ever on **nc listener**. 
The loop is required because nc stops when a communication ends on the client side.

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

## Setting up a VirtualHost on Apache2 to upload file to WDMyCloud

To make it short it didn't work due to weird setting up of Apache.

Instead I added to /etc/apache2/apach2.conf an Alias
```
# PJMD 20231105 add Alias for uploading files:
# curl -F "uploadedfile=@list.txt;filename=list.txt"  http://192.168.1.91/cgi-bin/netvue-upload.php

Alias "/netvue" "/var/www/netvue"
ScriptAlias "/cgi-bin/" "/usr/lib/cgi-bin/"
# END PJMD
```
The upload php script is located in **/usr/lib/cgi-bin/netvue-upload.php**
```
<?php

$target_path = "/home/pjmd2/ntv3/";
$target_path = $target_path . basename( $_FILES['uploadedfile']['name']);

echo "Source=" .        $_FILES['uploadedfile']['name'] . "<br />";
echo "Destination=" .   $destination_path . "<br />";
echo "Target path=" .   $target_path . "<br />";
echo "Size=" .          $_FILES['uploadedfile']['size'] . "<br />";

if(move_uploaded_file($_FILES['uploadedfile']['tmp_name'], $target_path)) {
echo "The file ".  basename( $_FILES['uploadedfile']['name']).
" has been uploaded";
} else{
echo "There was an error uploading the file, please try again!";
}
?>
```
The test page is in /var/www/netvue/upload.html
```
<html>
  <head>
  </head>
  <body>
    <h4>File uploads</h4>
    <form enctype="multipart/form-data" action="/cgi-bin/netvue-upload.php" method="post">
      <p>Select File:
        <input type="file" size="35" name="uploadedfile"/>
        <input type="submit" name="Upload" value="Upload"/>
      </p>
    </form>
  </body>
</html>
```
#### Ex;
http://192.168.1.91/netvue/upload.html

### Note
Since BusyBox doesn't implement **curl** and **wget** doesn't allow uploading files I am
resorting to using **netcat aka nc** and **dd**

If curl was available we could upload files with this command
```
curl -F "uploadedfile=@list.txt;filename=list.txt"  http://192.168.1.91/cgi-bin/netvue-upload.php
```


## File transfer with nc and dd
It is worth to mention that even though it is possible to run an **ftp server** on
BusyBox, it is doesn't work at least on this device.

### Commands to transfer files
On the server:
```
nc -l -p 8556 | dd bs=16M of=1696666325636_2314473851502382_1920x1080_8000_av.nvt3
```
On the client:
```
dd bs=16M if=1696651416372/1696666325636_2314473851502382_1920x1080_8000_av.nvt3  | nc 192.168.1.91 8556
```

## Clean up old recording 

See [netvue_rm_old_recordings.sh](https://github.com/pajmd/NetVueScript/blob/main/WDMyCLoud/netvue_rm_old_recordings.sh) script


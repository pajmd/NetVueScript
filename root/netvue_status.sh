#!/bin/bash

# Server side running on WDMyCloud

while true
do
nc -l -p 8888 >> netvue.log
done

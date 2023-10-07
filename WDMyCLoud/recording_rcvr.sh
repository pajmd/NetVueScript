#!/bin/bash

while true
do
nc -l -p 8556 | dd bs=16M of=payload.tar
tar xvf payload.tar
done

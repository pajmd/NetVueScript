#!/bin/bash
echo "Folder created on $(date -d @$(echo $1 | cut -c 27-36)) - $(ls -l $1 | wc -l) files"

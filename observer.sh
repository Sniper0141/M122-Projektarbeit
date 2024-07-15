#!/bin/bash

LAST=`stat "$1"`
while true; do 
    LAST=`stat "$1"`
    sleep 1
    NEW=`stat "$1"`
    if [ "$NEW" != "$LAST" ]; then
        source_file="${1}"   
        destination_dir="../${2}/${1}"    
        cp "$source_file" "$destination_dir"
        LAST="$NEW"
    fi
done
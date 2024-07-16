#!/bin/bash

while true; do 
    LAST=`stat "$1"`
    sleep 1
    NEW=`stat "$1"`
    if [ "$NEW" != "$LAST" ]; then
        source_file="${1}"   
        destination_dir="${3}/${2}/${1}"
        # wenn man auch versionieren möchte kann man anfangen die 
        # änderungs daten im filenamen zu hinterlegen aber unser script  
        # ist nur ein backup tool für den fall das die daten verloren gehen       
        cp "$source_file" "$destination_dir"
        LAST="$NEW"
    fi
done
#!/bin/bash

LAST=`stat "$1"`
while true; do 
    LAST=`stat "$1"`
    sleep 1
    NEW=`stat "$1"`
    if [ "$NEW" != "$LAST" ]; then
        echo "${1} has been changed"
        LAST="$NEW"
    fi
done


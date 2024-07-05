#!/bin/bash

DIR="$1"
declare -A FILE_MOD_TIMES

function readFilesFromDir(){
    cd "$DIR"
    LIST=`ls -p | grep -v /`        
    observeFilesForChanges $LIST
}

function observeFilesForChanges(){
    for FILE in $@; do { 
            checkFileForChanges $FILE
        }; 
    done
} 

function checkFileForChanges(){
    LAST=`stat "$1"`
    while true; do 
        echo $1
        # LAST=`stat "$1"`
        # sleep 1
        # NEW=`stat "$1"`
        # if [ "$NEW" != "$LAST" ]; then
        #     echo a file has been cahnged
        #     LAST="$NEW"
        # fi
    done
} 

readFilesFromDir 
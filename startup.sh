#!/bin/bash

# DIR="$1"
DIR="testfolder"
declare -A FILE_MOD_TIMES

function readFilesFromDir(){
    cd "$DIR"
    LIST=`ls -p | grep -v /`        
    startObserver $LIST

    # while true; do 
    #     NEW_LIST=`ls -p | grep -v /`        
    #     if [ "$NEW_LIST" != "$LIST" ]; then

    #     fi
    # done
}

function startObserver(){
    for FILE in $@; do
        sh ../observer.sh ${FILE} &
    done
} 

readFilesFromDir 
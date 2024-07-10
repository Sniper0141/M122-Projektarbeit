#!/bin/bash

DIR="$1"
declare -A FILE_MOD_TIMES

function readFilesFromDir(){
    cd "$DIR"
    LIST=`ls -p | grep -v /`        
    observeFilesForChanges $LIST
}

function observeFilesForChanges(){
    for FILE in $@; do
        sh ../observer.sh ${FILE} &
    done
} 

readFilesFromDir 
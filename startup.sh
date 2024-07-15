#!/bin/bash

declare -A FILE_MOD_TIMES

getDirFromList() {

    # testet ob es das file gibt 
    if [ "$#" -ne 1 ]; then
        echo "Usage: $0 <file>"
        exit 1
    fi

    while IFS='|' read -r folder1 folder2 || [ -n "$folder1" ]; do
        readFilesFromDir "$folder1" "$folder2" &
    done < "$1"
}

function readFilesFromDir(){
    cd "$1"
    LIST=`ls -p | grep -v /`
    echo $LIST
    echo $2        
    startObserver $LIST $2
}   

function startObserver(){ 
    num_args=$#
    for (( i=1; i<num_args; i++ )); do
        FILE="${!i}"
        sh ../observer.sh "${FILE}" "${!num_args}" & 
    done 
} 

getDirFromList "config"
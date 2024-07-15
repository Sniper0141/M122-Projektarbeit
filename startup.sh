#!/bin/bash

declare -A FILE_MOD_TIMES

getDirFromList(){

    # testet ob es das file gibt 
    if [ "$#" -ne 1 ]; then
        echo "Usage: $0 <file>"
        exit 1
    fi

    while IFS='|' read -r folder1 folder2 || [ -n "$folder1" ]; do
        readFilesFromDir "$folder1" "$folder2" &
    done < "$1"
}

readFilesFromDir(){
    current_directory=$(pwd)
    cd "$1"
    LIST=`ls -p | grep -v /`
    startObserver $LIST $current_directory $2
}   

startObserver(){ 
    num_args=$#
    for (( i=1; i<num_args-1; i++ )); do
        FILE="${!i}"
        PWD="$((num_args - 1))"
        sh ${!PWD}/observer.sh "${FILE}" "${!num_args}" "${!PWD}" & 
    done 
} 

getDirFromList "config"
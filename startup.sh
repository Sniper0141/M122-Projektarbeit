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

    # hier sollte es in jedem folder weiter schauen ob neue files auftauchen 
    # und je nach dem eine neue subshell erstellen aber funktioniert nicht
    # while true; do 
    #     list1=($LIST)
    #     sleep 1
    #     NEW_LIST=$(ls -p | grep -v /)
    #     list2=($NEW_LIST)

    #     list1_sorted=($(printf "%s\n" "${list1[@]}" | sort))
    #     list2_sorted=($(printf "%s\n" "${list2[@]}" | sort))

    #     l2=" ${list2_sorted[*]} "
    #     for item in ${list1_sorted[@]}; do
    #         if ! [[ $l2 =~ " $item " ]] ; then
    #             startObserver $item
    #         fi
    #     done
        
    #     l1=" ${list1_sorted[*]} "
    #     for item in ${list2_sorted[@]}; do
    #         if ! [[ $l1 =~ " $item " ]] ; then
    #             rm $item
    #         fi
    #     done
    done
}   

startObserver(){ 
    num_args=$#
    PWD="$((num_args - 1))"

    # testet ob es den directory gibt wohin es die backups speichern sollte  
    if [ ! -d "${!PWD}/${!num_args}" ]; then
        mkdir -p "${!PWD}/${!num_args}"
        echo "dir ${!PWD}/${!num_args} created"
    fi

    for (( i=1; i<num_args-1; i++ )); do
        FILE="${!i}"
        sh ${!PWD}/observer.sh "${FILE}" "${!num_args}" "${!PWD}" & 
    done 
} 



getDirFromList "config"

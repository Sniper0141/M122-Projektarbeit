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

    while true; do 
        list1=($LIST)
        sleep 1
        NEW_LIST=$(ls -p | grep -v /)
        list2=($NEW_LIST)

        list1_sorted=($(printf "%s\n" "${list1[@]}" | sort))
        list2_sorted=($(printf "%s\n" "${list2[@]}" | sort))

        # Capture the difference between the lists in a variable
        diff1=$(comm -23 <(printf "%s\n" "${list1_sorted[@]}") <(printf "%s\n" "${list2_sorted[@]}"))
        diff2=$(comm -13 <(printf "%s\n" "${list1_sorted[@]}") <(printf "%s\n" "${list2_sorted[@]}"))

        # Combine the differences
        combined_diff=$(printf "%s\n%s\n" "$diff1" "$diff2" | sort | uniq)

        if [ -n "$combined_diff" ]; then
            newFile="$combined_diff"
            startObserver $newFile $current_directory $2
            LIST=$NEW_LIST
        fi
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
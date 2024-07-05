#!/bin/bash

DIR="$1"
declare -A FILE_MOD_TIMES

for FILE in "$DIR"/*; do
  [ -f "$FILE" ] && FILE_MOD_TIMES["$FILE"]=$(stat -c %Y "$FILE")
done

while true; do
  sleep 1
  for FILE in "$DIR"/*; do
    if [ -f "$FILE" ]; then
      NEW_MODIFIED_TIME=$(stat -c %Y "$FILE")
      
      if [ "$NEW_MODIFIED_TIME" != "${FILE_MOD_TIMES["$FILE"]}" ]; then
        # here is command to save to new location  
        FILE_MOD_TIMES["$FILE"]="$NEW_MODIFIED_TIME"
      fi
    fi
  done
done
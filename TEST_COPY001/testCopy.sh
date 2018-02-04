#!/bin/bash

#set input file
DATA_SOURCE="data_if.dat"
#set output file
DATA_LOAD="data_copy.data"
#set max records
MAX_COUNT=$1

echo "test copy start!"

#clear data output file
cat /dev/null > ${DATA_LOAD}

int=${MAX_COUNT}
while [ $int -gt 0 ]
#echo $int
do
  cat ${DATA_SOURCE} >> ${DATA_LOAD}
  #echo $int
  let int-=1
done

echo "test copy finished!"

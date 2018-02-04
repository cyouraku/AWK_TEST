#!/bin/bash

#set input file
DATA_SOURCE="data_if.dat"
#set output file
DATA_LOAD="data_copy.data"

echo "test copy start!"

#clear data output file
cat /dev/null > ${DATA_LOAD}

int=0
while [ $int -lt 1000 ]
#echo $int
do
  cat ${DATA_SOURCE} >> ${DATA_LOAD}
  echo $int
  let int+=1
done

echo "test copy finished!"

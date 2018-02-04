#!/bin/bash

#set input file
DATA_SOURCE="data_if.dat"
#set output file
DATA_LOAD="data_load.data"

echo "test awk start!"

#clear data output file
cat /dev/null > ${DATA_LOAD}

awk '
BEGIN{FS="";OFS=",";FIELDWIDTHS="1 2 2 2";count=1;}
{
  if($0!=""){
    print count,$1,$2,$3,$4
    count+=1
  }
}

END{}
' ${DATA_SOURCE} >> ${DATA_LOAD}


cat ${DATA_LOAD}

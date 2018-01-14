#!/bin/bash
echo "Process start!"
date

#define file names
LOG_FILE=log/testWk01.log
LOAD_FILE=file/food.data
DATA_SOURCE=licai01
SHORI_FILE=file/food_shori.data
SUMMARY_SHORI=file/summary_shori.log

#check log file existing
cat /dev/null >  log/testWk01.log
cat /dev/null >  file/food.data
cat /dev/null >  file/food_shori.data
cat /dev/null >  file/summary_shori.log

#collecting food expense records
awk -v logFile="${LOG_FILE}" '
    BEGIN{FS=",";print "Food Record Summary";cnt=0;sum=0;}
{
    print "DEBUG INFO: expense = " substr($0,20,4) >> logFile
    print "DEBUG INFO: $5= " $5 >> logFile
    if(substr($0,20,4)=="Food"){
        print $0
        cnt+=1
        sum+=$5
    }
}
    END{printf "Food records total: %d Amount total: %d \n", cnt,sum > logFile }
' "${DATA_SOURCE}" > "${LOAD_FILE}" 

#remove duplicated date records
awk -v logFile="${LOG_FILE}" '
    BEGIN{FS=",";print "No Duplicate Records Summary";date0="";date1="";cnt=0;sum=0;}
{
    date1=date0
    date0=substr($0,1,10)
    print "DEBUG INFO: $5= " $5 >> logFile
    if(date1!=date0){
      print $0
      cnt+=1
      sum+=$5
    }
}
    END{printf "No duplicate records total: %d Amount total: %d \n", cnt,sum >> logFile}
' "${LOAD_FILE}" > "${SHORI_FILE}"

#Add Summary Info to SHORRI_FILE
awk -v shoriLog="${SUMMARY_SHORI}" '
   BEGIN{FS=",";cnt=0;sum=0;}
{
  cnt+=1
  cum+=$5
}
   END{printf "No duplicate records total: %d Amount total: %d \n", cnt,sum > shoriLog}
' "${SHORI_FILE}"
cat ${SUMMARY_SHORI} >> ${SHORI_FILE}

echo "Process end!"
date

exit

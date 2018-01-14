#!/bin/bash
echo "Process start!"
date

#define file names
DATA_SOURCE=input.data
LOG_FILE=log/testWk02.log
LOAD_FILE=file/load.data
SHORI_LOG=log/shori.log

#check log file existing
cat /dev/null >  ${LOG_FILE}
cat /dev/null >  ${LOAD_FILE}
cat /dev/null >  ${SHORI_LOG}

#collecting pattern "GA123"
awk -v logFile="${LOG_FILE}" '
    BEGIN{FS="";OFS=",";FIELDWIDTHS="5 5 5 5";print "GA123 Collections";cnt=0;}
{
    print "DEBUG INFO: $1 = " $1 >> logFile
    if(substr($1,1,2)=="GA"){
        print substr($1,1,2),substr($1,3,3)
        cnt+=1
    }
    print "DEBUG INFO: $2 = " $2 >> logFile
    if(substr($2,1,2)=="GA"){
        print substr($2,1,2),substr($2,3,3)
        cnt+=1
    }
    print "DEBUG INFO: $3 = " $3 >> logFile
    if(substr($3,1,2)=="GA"){
        print substr($3,1,2),substr($3,3,3)
        cnt+=1
    }
    print "DEBUG INFO: $4 = " $4 >> logFile
    if(substr($4,1,2)=="GA"){
        print substr($4,1,2),substr($4,3,3)
        cnt+=1
    }
}
    END{ printf "GA total: %d \n", cnt > logFile }
' "${DATA_SOURCE}" > "${LOAD_FILE}" 


#Add Summary Info to LOAD_FILE
awk -v shoriLog="${SHORI_LOG}" '
    BEGIN{FS="";cnt=0;}
{
    #print "DEBUG INFO: $0 = " $0 >> shoriLog
    #print "DEBUG INFO: substr($0,3,1) = " substr($0,3,1) >> shoriLog
    if(substr($0,3,1)==","){
         cnt+=1
     }
}
    END{ printf "GA total: %d \n",cnt > shoriLog }
'  "${LOAD_FILE}" 
cat ${SHORI_LOG} >> ${LOAD_FILE}

echo "Process end!"
date

exit

#!/bin/bash 

OLDIFS=IFS
IFS='
'
for i in `ps -ef | grep teague  | grep sudo | grep ssh | egrep -v "ps|killmyself" | awk -F" " ' { print $2 } ' ` ; do 
IFS=OLDIFS
echo $i 
kill -9 $i 
IFS='
'
done 
exit 0 

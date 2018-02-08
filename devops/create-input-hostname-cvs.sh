#!/bin/bash 
OLDIFS=$IFS
while IFS=',' read hostname mac ipipmi ; do
#     echo $hostname $mac $ipipmi
     IFS=$OLD_IFS
     oct3=`echo $ipipmi | awk -F"." ' { print $3 } ' `
     oct4=`echo $ipipmi | awk -F"." ' { print $4 } ' `
     echo $hostname $mac 172.16.$oct3.$oct4 10.0.$oct3.$oct4  $ipipmi
done < data3.dat

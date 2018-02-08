#!/bin/bash 
count3=14
while [ $count3 -le 23 ] 
do 
# echo $count3
count=0
count2=1
while [ $count -le  15  ] 
do 
#   host  spmercer-23-${count}.es.its.nyu.edu | grep address
#   mgmt=`host  spmercer-23-${count}.es.its.nyu.edu | grep address | awk -F " " ' { print $4 } ' `

   mgmt=`host  spmercer-${count3}-${count}.es.its.nyu.edu | grep address | awk -F " " ' { print $4 } ' `
   value=`expr $count3 + 18`
   if [ $count2 -lt 10 ] 
   then 
   echo "c$value-0${count2} $mgmt " 
   else 
    echo "c$value-${count2} $mgmt " 
   fi 
   count=`expr $count + 1`
   count2=`expr $count2 + 1`
done 
   count3=`expr $count3 + 1`
done 

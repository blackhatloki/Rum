#!/bin/bash 
count=14
while [ $count -le  23 ] 
do 
   host  cmcmercer${count}.es.its.nyu.edu
   count=`expr $count + 1`
done 

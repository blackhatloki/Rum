#!/bin/bash 
PATH=/sbin:/bin:/usr/bin
export PATH 

for eth in `ifconfig -a | grep "^eth" | awk -F" " ' { print $1 } ' ` 
  do 
    echo $eth 
     ethtool $eth  | egrep -i "Speed:|Duplex:|Link detected:"
  done 

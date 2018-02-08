#!/bin/bash 
memtotal=`cat /proc/meminfo  | head -1 | awk -F":" ' { print $2 } ' `
echo $memtotal

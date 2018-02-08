#!/bin/bash 
threads=`lscpu | grep -i -E  "Thread" | awk -F":" ' { print $2 }'`
echo $threads

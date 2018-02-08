#!/bin/bash 
swap=`free -h | grep "Swap:" | awk -F" " ' { print $2 } ' `
echo $swap

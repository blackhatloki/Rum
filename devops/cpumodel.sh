#!/bin/bash 
modelname=`cat /proc/cpuinfo | grep "model name" | uniq | awk -F":" ' { print $2 } ' `
echo $modelname

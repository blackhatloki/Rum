#!/bin/bash 
timestamp=`date +%H%M-%m%d%y.$$`
nvidia-smi > /root/dump/nvidia-smi.$timestamp
top -b -o RES -n 1|head -22 > /root/dump/top-res.$timestamp
top -b -o VIRT -n 1|head -22 > /root/dump/top-virt.$timestamp

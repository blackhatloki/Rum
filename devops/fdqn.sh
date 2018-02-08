#!/bin/bash 
# clustername to this program
hostname=`hostname | awk -F"." ' { print $1 } ' ` 
echo $hostname.hpc.nyu.edu 

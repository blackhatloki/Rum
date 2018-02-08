#!/bin/bash 
numberofsockets=`cat /proc/cpuinfo | grep "physical id" |  sort -u | wc -l`
echo $numberofsockets

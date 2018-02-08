#!/bin/bash 
numberofens=`ip a s | egrep  "ens" | wc -l `
echo $numberofens

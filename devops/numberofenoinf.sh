#!/bin/bash 
numberofeno=`ip a s | egrep  "eno" | wc -l `
echo $numberofeno

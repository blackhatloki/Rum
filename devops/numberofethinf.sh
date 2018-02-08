#!/bin/bash 
numberofeth=`ip a s | egrep "eth[0-9]?[0-9]:" | wc -l `
echo $numberofeth

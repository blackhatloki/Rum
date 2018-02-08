#!/bin/bash 
hardware=`dmidecode | grep -i "Type:" | egrep "Rack|Server" | awk -F":" ' { print $2 }' `
echo $hardware

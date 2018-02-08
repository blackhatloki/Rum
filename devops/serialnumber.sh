#!/bin/bash
serialnumber=`dmidecode | grep -i "Serial Number:"  | head -1 | awk -F":" ' { print $2 } '`
echo $serialnumber

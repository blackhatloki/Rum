#!/bin/bash 
vendor=`dmidecode | grep "Vendor:" | awk -F":" ' { print $2 } '`
echo $vendor

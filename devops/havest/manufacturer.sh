#!/bin/bash 
Manufacturer=`dmidecode | grep "Manufacturer:" | head -1  |awk -F":" ' { print $2 } ' `
echo $Manufacturer

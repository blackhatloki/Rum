#!/bin/bash 
productname=`dmidecode | grep -i "Product Name:"  | head -1 | awk -F":" ' { print $2 } '`
echo $productname

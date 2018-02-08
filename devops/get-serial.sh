#!/bin/bash 
HOST=`hostname`
SERIAL=`dmidecode | grep "Serial Number:"   | head -1  | sed -e 's/^\t*//g' | sed -e 's/Serial Number: //g'`
echo "$HOST:$SERIAL"

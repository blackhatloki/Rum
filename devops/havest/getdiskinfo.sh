#!/bin/bash 
fdisk -l | grep -v "WARN" | grep Disk | grep sd[a-z] | awk -F" " ' { printf ("%s %s %s\n",$2,$3,$4)  } '  | sed -e 's/:/  /g' | sed -e 's/,//g'  | sort

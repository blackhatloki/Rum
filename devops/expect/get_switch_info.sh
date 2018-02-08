#!/bin/bash 
for i in `cat OA` ; do 
  echo $i 
  ./show_interconnect_info.exp $i | egrep "User Assigned Name:"
#  ./show_interconnect_info.exp $i | egrep "In-Band IPv4 Address:|User Assigned Name:"
done 

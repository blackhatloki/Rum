#!/bin/bash 
for i in `grep gpu /etc/hosts  | egrep -v "ib|ipmi|#" | awk -F" " ' { print $2 } ' ` ;  do  echo $i ; ssh $i "nvidia-smi | egrep \"Tesla|GTX\" | awk -F\" \" ' { printf(\"%s %s\n\",\$3,\$4) } '  | sort -u" ; done

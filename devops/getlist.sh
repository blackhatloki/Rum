#!/bin/bash 
grep $1 /etc/hosts  | egrep -v "ib|#|ipmi" | awk -F" " ' { print $2 } ' 

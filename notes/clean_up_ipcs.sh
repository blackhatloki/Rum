#!/bin/bash 
username=$1
ipcs -s | awk '/nrpe/ {system("ipcrm -s" $2)}'   

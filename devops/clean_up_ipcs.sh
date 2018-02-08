#!/bin/bash 
ipcs -s | awk '/nrpe/ {system("ipcrm -s" $2)}'   

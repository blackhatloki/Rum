#!/bin/bash 
. ./ENV.sh 
host=$1
ipmitool  -H $host -U $USER -P$PASS chassis status

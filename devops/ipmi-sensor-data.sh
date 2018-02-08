#!/bin/bash
. ./ENV.sh 
HOST=$1
ipmitool -v -I lanplus -H $HOST  -U $USER -P $PASS  sdr

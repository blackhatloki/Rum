#!/bin/bash 
node=$1 
reason="HardwareSupport"
echo "scontrol update NodeName=$node state=drain reason=\"${reason}\""
scontrol update NodeName=$node state=drain reason=\"${reason}\"
sinfo 

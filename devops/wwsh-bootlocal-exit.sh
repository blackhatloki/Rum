#!/bin/bash 
node=$1
echo "wwsh  -y  provision set $node --bootlocal=exit"
wwsh  -y  provision set $node --bootlocal=exit

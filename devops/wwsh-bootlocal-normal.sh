#!/bin/bash 
node=$1
echo "wwsh -y   provision set $node --bootlocal=normal"
wwsh -y   provision set $node --bootlocal=normal

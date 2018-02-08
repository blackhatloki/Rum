#!/bin/bash 
node=$1
wwsh -y   provision set $node --bootlocal=normal

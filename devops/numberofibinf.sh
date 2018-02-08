#!/bin/bash 
numberoibinterfaces=` ip a s | egrep "ib[0-9]?[0-9]:" | wc -l`
echo $numberoibinterfaces

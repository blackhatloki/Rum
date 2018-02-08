#!/bin/bash 
numberofp=`ip a s | egrep "p[0-9]p[0-9]:" | wc -l `
echo $numberofp

#!/bin/bash 
dmidecode | grep "Location In Chassis:" | sort -u | sed -e 's/^	*//g'  

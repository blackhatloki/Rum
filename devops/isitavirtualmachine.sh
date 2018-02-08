#!/bin/bash
vm=`dmidecode | egrep "Virtual" | head -1 | awk -F":" ' { print $2 } '`

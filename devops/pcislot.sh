#!/bin/bash 
dmidecode -t 9   | egrep "PCI|Bus" | egrep "Slot|Type|Bus Address:" | sed -e 's/^\t+*//g' | sed -e 's/0000://g'
for i in `dmidecode -t 9 | egrep "Bus" | egrep "Bus Address:" | sed -e 's/^\t+*//g' | sed -e 's/Bus Address://g' | sed -e 's/0000://g'` ; do 
lspci -s $i 
done

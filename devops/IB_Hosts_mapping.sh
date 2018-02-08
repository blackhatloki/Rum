#!/bin/bash 
ibhosts |  awk -F" " ' { printf("Port ->  %s  GUID %s  Hostname %s\n",$5,$3,$6) } ' > IB_HOSTS.mapping.txt

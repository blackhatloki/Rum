#!/usr/bin/python
import os 
import socket 

hostname = os.uname()[1]
chassis , node = hostname.split("-")
#print chassis 
#print node
num = int(node)
if num % 2 == 0: 
   print "10.0.1.244@o2ib10:10.0.1.243@o2ib10:/scratch /scratch lustre defaults,noauto,localflock      0 0"
else:
   print "10.0.1.144@o2ib10:10.0.1.143@o2ib10:/scratch /scratch lustre defaults,noauto,localflock      0 0"

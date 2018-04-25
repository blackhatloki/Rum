#!/usr/bin/env python 

import MySQLdb 

conn = MySQLdb.connect("172.16.0.42","tony","tony","hpcinventorydb") 
c=conn.cursor()

s = "select hostname from inventory"

try:
   # Execute the SQL command
   c.execute(s)
   # Fetch all the rows in a list of lists.
   results = c.fetchall()
except:
   print "Error: unable to fecth data"



c.close()

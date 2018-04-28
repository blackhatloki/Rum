#!/usr/bin/env python 

import MySQLdb 

conn = MySQLdb.connect("172.16.0.42","tony","tony","hpcinventorydb") 
c=conn.cursor()

s = "select * from inventory"

try:
   # Execute the SQL command
   c.execute(s)
   # Fetch all the rows in a list of lists.
   results = c.fetchall()
   print results
      # Now print fetched result
#      print "productid=%s,country=%s,site=%s,floor=%s,room=%s,ide=%s,cabinet=%s,stype=%s,chassis=%s,cluster=%s,monitoring=%s,uposition=%s,hostname=%s,slot=%s,mtype=%s,mname=%s,serialnum=%s,commission=%s,desciptions=%s,status=%s,pi=%s,school=%s,dept=%s" \
#             (productid,country,site,floor,room,ide,cabinet,stype,chassis,cluster,monitoring,uposition,hostname,slot,mtype,mname,serialnum,commission,desciptions,status,pi,school,dept )
except:
   print "Error: unable to fecth data"



c.close()

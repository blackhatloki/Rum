#!/usr/bin/env python 

import MySQLdb 

conn = MySQLdb.connect("172.16.0.42","tony","tony","hpcinventorydb") 
c=conn.cursor()

s = "select * from inventory where hostname = compute-2-14"

try:
   # Execute the SQL command
   c.execute(s)
   # Fetch all the rows in a list of lists.
   results = c.fetchall()
   for row in results:
      productid = row[0]
      country = row[1]
      site = row[2]
      floor = row[3]
      room  = row[4]
      ide  = row[5]
      cabinet  = row[6]
      stype  = row[7]
      chassis  = row[8]
      cluster  = row[9]
      monitoring  = row[10]
      uposition  = row[11]
      hostname  = row[12]
      slot  = row[13]
      mtype  = row[14]
      mname  = row[15]
      serialnum  = row[16]
      commission  = row[17]
      description = row[18]
      status   = row[19]
      pi = row[20]
      school = row[21]
      dept = row[22]
      # Now print fetched result
#      print ("productid=%s " % (productid))
#      print ("productid=%s,country=%s,site=%s,floor=%s" % (productid,country,site,floor))
#      print ("productid=%s,country=%s,site=%s,floor=%s,room=%s,ide=%s,cabinet=%s,stype=%s,chassis=%s,cluster=%s,monitoring=%s,uposition=%s,hostname=%s" % (productid,country,site,floor,room,ide,cabinet,stype,chassis,cluster,monitoring,uposition,hostname))
#      print ("productid=%s,country=%s,site=%s,floor=%s,room=%s,ide=%s,cabinet=%s,stype=%s,chassis=%s,cluster=%s,monitoring=%s,uposition=%s,hostname=%s,slot=%s,mtype=%s,mname=%s,serialnum=%s" % (productid,country,site,floor,room,ide,cabinet,stype,chassis,cluster,monitoring,uposition,hostname,slot,mtype,mname,serialnum))
      print ("productid=%s,country=%s,site=%s,floor=%s,room=%s,ide=%s,cabinet=%s,stype=%s,chassis=%s,cluster=%s,monitoring=%s,uposition=%s,hostname=%s,slot=%s,mtype=%s,mname=%s,serialnum=%s,commission=%s,desrciption=%s,status=%s,pi=%s,school=%s,dept=%s" % (productid,country,site,floor,room,ide,cabinet,stype,chassis,cluster,monitoring,uposition,hostname,slot,mtype,mname,serialnum,commission,description,status,pi,school,dept))
      # print ("productid=%s,country=%s,site=%s,floor=%s,room=%s,ide=%s,cabinet=%s,stype=%s,chassis=%s,cluster=%s,monitoring=%s,uposition=%s,hostname=%s,slot=%s,mtype=%s,mname=%s,serialnum=%s,commission=%s,desciptions=%s,status=%s,pi=%s,school=%s,dept=%s" % (productid,country,site,floor,room,ide,cabinet,stype,chassis,cluster,monitoring,uposition,hostname,slot,mtype,mname,serialnum,commission,desciptions,status,pi,school,dept))
except:
   print "Error: unable to fecth data"



c.close()

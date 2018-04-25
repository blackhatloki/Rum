#!/usr/bin/env python 

import MySQLdb 

conn = MySQLdb.connect("172.16.0.42","tony","tony","hpcinventorydb") 
c=conn.cursor()
c.execute("SELECT VERSION()")

# Fetch a single row using fetchone() method.
data = c.fetchone()
print "Database version : %s " % data

c.close()

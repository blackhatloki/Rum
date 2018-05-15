#!/usr/bin/env python 

import MySQLdb 

conn = MySQLdb.connect(host = "172.16.0.42", user = "tony", passwd = "tony", db = "hpcinventorydb", port = 3306) 
c=conn.cursor()
c.execute("SELECT VERSION()")


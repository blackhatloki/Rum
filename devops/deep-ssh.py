#!/usr/bin/python

import os
import sys
import string

def usage():
	sys.stderr.write(sys.argv[0]+ ' ssh_opts host2!host2!...!hostn command\n')
	sys.exit(1)

def even(n):
	if (n/2)*2 == n:
		return 1
	else:
		return 0
	
def escapequote(n,single):
	#print n
	if single:
		return '\\'*(pow(2,n+1)-1)+"'"
	else:
		return '\\'*(pow(2,n+1)-1)+'"'

# two quoting options: alternating ' and ", vs only " with exponential
# backslashing

# BTW, this may not work as well with *csh as sh/ksh/bash!

alternate = 1

if len(sys.argv) != 4:
	usage()

optional_opts=sys.argv[1]
# doesn't fly
#always_opts='-X -A -o SendEnv'
always_opts='-X -A'

chain=string.splitfields(sys.argv[2],',')

number=len(chain)
if alternate == 1:
	# this sorta works, but not always
	cmd='ssh '+always_opts+' '+optional_opts+' '+chain[number-1]+" '"+sys.argv[3]+"'"
	for hostno in range(number-2,-1,-1):
		if even(hostno):
			cmd = "ssh "+always_opts+' '+optional_opts+' '+chain[hostno]+" '"+cmd+"'"
		else:
			cmd = 'ssh '+always_opts+' '+optional_opts+' '+chain[hostno]+' "'+cmd+'"'
else:
	# I believe this is how things are -supposed- to work...
	cmd='eval ssh '+always_opts+' '+optional_opts+' '+ chain[number-1] + ' ' + \
		escapequote(number-1,1) + ' eval ' + sys.argv[3] + ' ' + \
		escapequote(number-1,1)
	for hostno in range(number-2,-1,-1):
		cmd = "eval ssh "+always_opts+' '+optional_opts+' '+ \
			chain[hostno]+" "+escapequote(hostno,0)+' '+cmd+ \
			' '+escapequote(hostno,0)

sys.stderr.write('Executing: '+cmd+'\n')
os.system(cmd)

#!/bin/sh


# "metatree.sh":  from http://www.bolthole.com/solaris/metatree.sh
# Last modified:  June 9th, 2006

# This is a fairly trivial program to indent the output of
# metastat -p
# It has only been tested on simple mirrors.
# If you want to send me the raw output of "metastat -p"
# on a more complicated system, I would be happy to fix this up
#
#  -  phil@bolthole.com
#     http://www.bolthole.com/solaris/

if [ -x /usr/sbin/metastat ] ; then
	METASTAT="/usr/sbin/metastat"
fi
if [ -x /usr/opt/SUNWmd/sbin/metastat ] ; then
	METASTAT="/usr/opt/SUNWmd/sbin/metastat"
fi
if [ "$METASTAT" = "" ] ; then
	if [ -x `which metastat` ]; then 
	 	METASTAT=`which metastat`
	fi
fi

if [ ! -f $METASTAT ] ; then
        echo "Sorry, metastat not installed on this system"
        exit
fi


# The concept here; 
#  metastat -p already does half the work. it sorts devices to be grouped,
# and puts the highest level metadevice first, always. So it is kind of like
# a directed graph. We just have to figure out how many nodes "down" we are.
# Which, unfortunately, could get complicated.
# So... fake it, for now.
# Really, I need to count the number of times a device has been referenced
# previously, and indent it that many times
# 

$METASTAT -p $* |
awk '
$2 == "-m"      { 
                        print;
			# Always top-level, so print as-is. 
			# But then figure out whether we need to indent the
			# next ONE, or TWO, lines.
			# is it a oneway mirror, or a two-way?
			# 
			tcount=NF -3

                        next;
                }


# Special case for  "d00 1 1 d01" type nesting
NF == 4	&& $4 ~ /^d/ {tcount++ ; }

# And for all non-mirror metadevices...
# print out the line, and indent it if we are in a mirrored nesting
                { if(tcount>0){ printf(" "); tcount=tcount-1;}
                  print;
		}
'

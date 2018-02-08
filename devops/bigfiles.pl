#!/usr/bin/perl
#
# Set line #1 to the path of your installed Perl binaries. On 
# Solaris 8 perl supplied with the distribution in /usr/bin/perl.   
#
# bigfiles - looks through sub-directory tree lists files bigger than N kbytes.
#            Defaults to 500 kbytes.
#
# 15 Nov 1996	Scott Babb	Created.
#
# 19 Nov 1996	Scott Babb	Changed traverse to not descend into 	
#				symlinked dirs.
#
# 09 Sep 2000	Eric Nielsen    Changed to report Kilobytes as most people
#				care about kilobyte resolution. 
#				Submitted to BigAdmin.. www.sun.com/bigadmin
#
# Usage: bigfiles [#kbytes] 
#

$kbyte = 1024;			# Number of bytes in a kbyte
$minsize = $kbyte * 500;	# Default Minimum Size of a file (1000 kbytes)

#
# Process size argument, if any
#

if ($#ARGV >= 0) {
    $minsize = $kbyte * $ARGV[0];
}

#
# scan throught the directory tree
#

&traverse('.');

sub traverse {
    local($dir) = shift;
    local($path);
    unless (opendir(DIR, $dir)) {
        warn "Can't open $dir\n";
        closedir(DIR);
        return;
    }
    foreach (readdir(DIR)) {
        next if $_ eq '.' || $_ eq '..';
        $path = "$dir/$_";
        if ((-d $path) && (! -l $path)) {	# non-symlink dir, enter it
            &traverse($path);
        } elsif ((-f _) && (! -l $path)) {	# plain file, but not a symlink
            $size = -s $path;			# get the size in bytes
	     $ksize = $size / 1000;          # convert to megabytes 
            if ($size > $minsize) {
                $age = -A $path;		# get the age in days
                printf "%9d Kilobytes %4d days %s\n",$ksize,int($age),$path;
            }
        }
    }
    closedir(DIR);
}


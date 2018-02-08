#!/usr/bin/perl
use strict;

use Getopt::Long;
use Sys::Hostname;

#Metadb and metastat are in /usr/sbin under Sol 8,
#and /usr/opt/SUNWmd/sbin in 7
my $meta_root_dir="/usr/opt/SUNWmd";

my $metadb="$meta_root_dir/sbin/metadb";
my $metastat="$meta_root_dir/sbin/metastat";
$metadb = "/usr/sbin/metadb"
	if (! -e $metadb && -e "/usr/sbin/metadb");
$metastat = "/usr/sbin/metastat"
	if (! -e $metastat && -e "/usr/sbin/metastat");


#Sendmail binary
my $SENDMAIL = '/usr/lib/sendmail';
#Routine to safely send email
sub sendmail($$$)
{	my $recipients = shift;
	my $subject = shift;
	my $data = shift;
	my $mailfrom = "check-disksuite-disks.pl <payerle\@physics.umd.edu>";

	#No choice but to die here if fails, as fatal_error calls this routine
	open(MAIL,"| $SENDMAIL -oi -t") or
		die "Unable to open sendmail ($SENDMAIL)";

	print MAIL <<EOF;
From: $mailfrom
To: $recipients
Subject: $subject

$data
EOF
 	close MAIL or die "Unable to close pipe to sendmail ($SENDMAIL)";
}

sub usage()
{	print STDERR<<EOF;
$0: checks status of DiskSuite disks/db using
metadb and metastat commands
Usage:
	$0 --help
		: prints this help message
	$0 --verbose
		: Prints verbose summary to stdout, no email
	$0 --mail emailaddr1 [ --mail emailaddr2 ]* [--verbose]
		: sends email to specified addresses if error seen
		If no problems, no email unless --verbose specified,
		in which case also reports to stdout.

EOF
}

sub examine_metadb(;$)
#Runs metadb command and looks for any problems with the database replicas
#Returns an array of error messages, one per line.
#Single argument is verbose, which if set means return a status ok message.
{	my $verbose = shift || 0;

	open(PIPE, "$metadb 2>&1 |") or die "Unable to open pipe to $metadb";
	my @output = <PIPE>;
	close(PIPE) or die "Unable to close pipe to $metadb";

	my @results = ();

	if ( ! scalar(@output) )
	{	push @results, "Unknown error with metadb, no output\n";
		return @results;
	}

	my $line = shift @output;
	if ( $line !~ /^\s*flags\s*first blk\s*block count\s*$/ )
	{	push @results, "Unknown error with metadb, no title line\n";
		push @results, "Instead, got $line";
	}

	my ($flags, $blk1,$nblks,$slice,$repcnt);
	my %badslices = ();

	$repcnt = 0;
	foreach $line (@output)
	{	#Flags section is fixed char positions
		$flags = substr $line, 0, 20;
		#Rest is context sensitive
		$blk1 = substr $line, 20;
		$blk1=~s/\s*$//;
		#Check looks valid
		if ( $blk1=~/^\s*([0-9]+)\s+([0-9]+)\s+(.*)$/ )
		{	$blk1 = $1;
			$nblks=$2;
			$slice = $3;
		} else
		{	push @results, "Metadb error: can't parse line $line\n";
			next;
		}
		if ( $nblks != 1034 && $nblks != 8192 )
		{	push @results,
				"Block count wrong ($nblks), may be error:
$line\n";
			next;
		}
		if ( $slice !~ /^\s*\/dev\/dsk\/c[0-9]t[0-9]d[0-9]s[0-9]\s*$/)
		{	push @results,
				"Slice looks wrong, may be error: $line\n";
			next;
		}
		$repcnt++;

		if ( $flags =~ /[^\sampluo]/ )
		{	$flags =~ s/\s//g;
			$flags =~ s/[ampluo]//g;
			my @tmp = split "", $flags;
			#IF already in badslices, merge the flags
			if ( exists $badslices{$slice} )
			{	my $tmp2 = $badslices{$slice};
				push @tmp, @$tmp2;
				my %tmp = map {$_ => undef } @tmp;
				@tmp = keys %tmp;
			}
			@tmp = sort @tmp;
			$badslices{$slice} = [@tmp];
		}
	}

	foreach $slice ( keys %badslices )
	{	$blk1 = $badslices{$slice};
		$flags = join "", @$blk1;
		push @results, "DB probs on slice $slice, flags $flags\n";
	}

	if ($verbose && ! scalar(@results) )
	{	push @results, "DB OK: metadb shows $repcnt good replicas\n";
	}

	return @results;
}


sub examine_metastat(;$)
#Runs metastat command and looks for any problems with the mirrors
#Returns an array of error messages, one per line.
#Single argument is verbose, which if set means return a status ok message.
{	my $verbose = shift || 0;

	open(PIPE, "$metastat 2>&1 |") or
		die "Unable to open pipe to $metastat";
	my @output = <PIPE>;
	close(PIPE) or die "Unable to close pipe to $metastat";

	my @results = ();
	my @oks=();

	if ( ! scalar(@output) )
	{	push @results, "Unknown error with metastat, no output\n";
		return @results;
	}


	my $mirror_cnt=0;
	my $smirror_cnt=0;
	my $line;
	my $mode = "none";
	my ($mirror,$smirror, $sms, $mstat, $status);

	foreach $line (@output)
	{	#Check for errors
		if ( $line =~ /^metatstat:/ )
		{	push @results, "Metatat error: $line";
			next;
		}

		if ( $mode eq "none" )
		{	#No history with what was read
			if ( $line =~ /^(d[0-9]):\s*Mirror\s*$/ )
			{   if ( defined $mirror )
			    {	#SAve previous results
				if ( $mstat )
				{	push @results, "$mstat probs on mirror
$mirror (submirrors $sms)\n";
				} else
				{	push @oks, "Mirror $mirror OK:
submirrors $sms\n";
				}
			    }
			    $mode = "mirror";
		    	    $mirror = $1;
			    $mstat = 0;
			    $sms = "";
			    $mirror_cnt++;
			    next;
			}
			next;
		}
		if ( $mode eq "mirror" || $mode eq "state" )
		{	#Previous line was start of mirror record
			# or a submirror state line
			if ( $line =~ /^\s*Submirror\s*[0-9]:\s*(d[0-9]+)\s*$/)
			{	$smirror = $1;
				if ($sms) { $sms = "$sms, $smirror"; }
				else { $sms = $smirror; }
				$mode = "submirror";
				$smirror_cnt++;
				next;
			}
			if ( $mode eq "mirror" )
			{	#Should have gotten a submirror line
				push @results, "Metastat prob: mirror record not
immediately followed by submirror lines, mirror=$mirror\n";
				$mode = "none";
				next;
			}
			#IF submirror line not following a submirror state,
			#must of reached end of submirror
			$mode = "none";
			next;
		}

		if( $mode eq "submirror" )
		{	#Previous line was a submirror stanza inside mirror
			#stanza.  Must be followed by a state line
			if ( $line =~ /^\s*State:\s*(.*)$/ )
			{	$status = $1;
				$status =~ s/\s*$//;
				if ( $status ne "Okay" )
				{	$mstat++;
					push @results, "Problem with submirror
$smirror of $mirror: State is $status\n";
				}
				$mode = "state";
				next;
			}
			push @results, "Metastat problem: submirror line not
followed immediately by State line, submirror $smirror\n";
				$mode = "none";
			next;
		}
	}
	#SAve reulsts of last mirror
	if ( ! defined $mirror)
	{	push @results, "Metastat error: no mirrors seen\n";
	} else
	{  	if ( $mstat )
		{	push @results, "$mstat probs on mirror $mirror
(submirrors $sms)\n";
		} else
		{	push @oks, "Mirror $mirror OK: submirrors $sms\n";
		}
	 }

	if ($verbose && ! scalar(@results) )
	{	push @results, "All Mirrors OK\n";
		push @results, @oks;
	}

	return @results;
}


#Main

#for taint
$ENV{"PATH"}="";

my $VERBOSE=0;
my @mailto=();
my $help=0;

&GetOptions( 	"help|h"=>\$help,
		"mail|m=s@"=>\@mailto,
		"verbose|v!"=>\$VERBOSE,
	);

if ($help ) { usage(); exit 0; }

if (scalar(@ARGV) ) { usage(); die "Too many arguments"; }

if ( ! ( $VERBOSE || scalar(@mailto) ) )
{	usage();
	die "At least one of --mail or --verbose must be specified";
}

my @probs = examine_metadb($VERBOSE);

my @tmp = examine_metastat($VERBOSE);

push @probs, @tmp;

if ($VERBOSE)
{	print @probs;
}
if ( scalar(@mailto) && ( $VERBOSE || scalar(@probs) ) )
{	my $txt = join "", @probs;
	my $recips = join ", " , @mailto;
	my $hostname = hostname();
	my $subj = "DiskSuite Probs on $hostname";

	sendmail($recips,$subj,$txt);
}

#!/usr/bin/perl

# dpscan.pl
# Capture all types of Discover Packet Data and report for each viable interface
#


use Getopt::Long;

$option_cdp = "";
$option_lldp = "";
$option_all = "";
$option_quick = "";
@option_ifs = ();

$num_packets = 3; # default number of packets to wait for when using --all option

# keeps track of what's been printed thus far, since we're checking multiple packets in case
# both CDP and LLDP packeets are floating around. We only need 1 but we won't know which is the right one
# so we capture 3 packets and display all that are unique
%printed_dpscan = ();

@print_order = ();
%exception_hash=();
%if_hash = ();

## VARIABLES SET BELOW BASED ON SLES VERSION ##
# $wshome = "/app/llt-tools";
# $bindir = "$wshome/bin";
# $ENV{'PATH'} = "$bindir:$ENV{'PATH'}";
# $ENV{'WSHOME'} = "$wshome";
# $ENV{'LD_LIBRARY_PATH'}="$ENV{'LD_LIBRARY_PATH'}:$wshome/lib";


chop($host = `uname -n`);

#___BEGIN MAIN_____________

# log usage to messages
sLogMessages(@ARGV);

# set variables based on SLES version - currently works with 10/11
$os_version = sGetOSVersion ();
if ($os_version =~ /SLES11/) {
	$wshome = "/app/llt-tools/scripts/WS-SLES11/usr";
	$ENV{'LD_LIBRARY_PATH'}="$ENV{'LD_LIBRARY_PATH'}:$wshome/lib:$wshome/lib64";
	$bindir = "$wshome/bin";
	$tsharkbin = "$bindir/tshark.bin";
} elsif ($os_version =~ /SLES/) {
	# other versions of SLES
	$wshome = "/app/llt-tools";
	$ENV{'LD_LIBRARY_PATH'}="$ENV{'LD_LIBRARY_PATH'}:$wshome/lib";
	$bindir = "$wshome/bin";
	$tsharkbin = "$bindir/tshark.bin";
} elsif ($os_version =~ /REDHAT/) {
	$bindir = "/usr/sbin";
	$tsharkbin = "$bindir/tshark";
} else {
	print "Unrecognized OS (SLES and REDHAT compatible) - Environment/Script variables not able to set properly. Exiting.\n";
	exit;
};

$ENV{'PATH'} = "$bindir:$ENV{'PATH'}";
$ENV{'WSHOME'} = "$wshome";

sInit();
# if (! -e "$bindir/tshark") {
if (! -e "$tsharkbin") {
	print "No tshark present in $bindir. Required for this script.\nPlease install and try again.\n";
	exit;
};
sGetExceptions();
sGetInterfaceIPnMAC();
sGetInterfaces();
if ($option_doflip) {
	sDoFlips();
};

#___END MAIN_____________

# Get IP and MAC info for each interface
sub sGetInterfaceIPnMAC {
	my @ipinfo = `ifconfig -a`;
	my @bonded_ifs = ();	# keeps track if ifs within a bond
	my $cur_interface = ();
	my $new_interface = ();
	my $info = "";
	# go through ifconfig
	for (@ipinfo) {
		chomp;
		my ($tmp_interface,$info) = split(/\s+/,$_,2);
		($new_interface,$vip) = split(/\:/,$tmp_interface);
		# strip off vips and for each new interface, check if it's a bond and if so, get the slave specific mac info
		if ($new_interface) {
			$cur_interface = $new_interface;	
			# if it's a bond - get the actually HW addr this way
			if (-e "/proc/net/bonding/$cur_interface") {
				# then get the bonded mac - this should overwrite any interface HW addresses since it's the correct data
				sGetBondedMAC($cur_interface);
			};
		};
		if ($info =~ /inet /) {
			my ($j1,$j2,$ip,$j3,$bcast,$j4,$mask) = split(/\s+|\:/,$info,7);
			$interfaces_hash{$cur_interface}{"ip"} = $ip;
		# else if this line has the HW address and it's not already in there (most likely from a bond if in there) then go ahead
		} elsif (($info =~ /Link/) && (! exists $interfaces_hash{$cur_interface}{"hwaddr"})) {
			my ($j1,$j2,$j3,$hwaddr,$j4) = split(/\s+/,$info,5);
			$interfaces_hash{$cur_interface}{"hwaddr"} = $hwaddr;
		};
	};
};

# get mac info for bonded interface
sub sGetBondedMAC {
	my $bond = shift;
	my $cur_interface = "";
	my $mac = "";
	my @bondinfo = `cat /proc/net/bonding/$bond`;
	for (@bondinfo) {
		chomp;
		my ($label,$data) = split(/\:/,$_,2);
		$data = sStripExtraSpaces($data);
		if ($label =~ /Slave Interface/) {
			$cur_interface = $data;
		};
		if ($label =~ /HW addr/) {
			$mac = $data;
		};
		# once we have the mac and interface then put it all into the interfaces_hash
		if (($mac) && ($cur_interface)) {
			$interfaces_hash{$cur_interface}{"hwaddr"} = $mac;
			$cur_interface = "";
			$mac = "";
		};
	};
};

sub sLogMessages {
	my @argslist = @_;
	my $argslist = join(" ",@argslist);
	my $basename = substr($0, rindex($0,"/")+1,length($0)-rindex($0,"/")-1);
	my $command = "$basename $argslist";
	`logger -p local0.info \"$command\"`;
};

sub sGetOSVersion {
	if (-e "/etc/SuSE-release") {
		chop(my $versionline = `cat /etc/SuSE-release |grep VERSION`);
		my ($label,$version) = split(/\=/,$versionline,2);
		$version = sStripExtraSpaces($version);
		return "SLES" . $version;
	} elsif (-e "/etc/redhat-release") {
		return "REDHAT";
	} else {
		return 0;
	};
};

sub Usage {
	print "\n$0 [ --cdp | --lldp | --all ] [--ifs <interface names (space separated)>] [--quick] [--doflip]\n";
	print "\n";
	print "      --quick  : * ONLY AFFECTS --all OPTION. This will only wait for 1st discovery packet, whether lldp or\n";
	print "                 cdp. You may get incorrect results in some cases where different discovery packets are allowed\n";
	print "                 through the directly connected switch from other switches. Network engineering is working on\n";
	print "                 turning this off.\n";
	print "      --doflip : Will flip any existing bonds and test both sides, then return bond to initial state.\n";
	print "\n";
	print "Note: Default is all if no arguments specified\n\n";
	exit;
};

sub sInit {
	my $option_return = GetOptions (
	'cdp'      	=> \$option_cdp,
	'lldp'      	=> \$option_lldp,
	'doflip'      	=> \$option_doflip,
	'all'      	=> \$option_all,
	'quick'      	=> \$option_quick,
	'ifs=s{1,}'		=> \@option_ifs,
	'help'          => \$option_help);

        # Initialize the hostlist
        if (($option_help) || (! $option_return)) {
                Usage ();
        };

	if ((! $option_cdp) && (! $option_lldp) && (! $option_all)) {
		$option_all = 1;
	};
	if ($option_quick) {
		$num_packets = 1;
	};

	if (($option_cdp) && ($option_lldp)) {
		$option_all = 1;
	};
	
	# clean up old interface tmp files
	`rm /tmp/*.dpout 2> /dev/null`;
};

# Go through bonding information and set all Slave interfaces as exceptions since we need to use the bonded interface name
sub sGetExceptions {
	# my @bondinfo = `cat /proc/net/bonding/*| grep "Slave Interface" | awk -F: '{print \$2}'`;
	if (-d "/proc/net/bonding") {
		my @bondinfo = `find /proc/net/bonding |xargs grep "Slave"`;
		for (@bondinfo) {
			my ($filename,$junk,$interface) = split(/:+/,$_,3);
			my ($bond,$junk2) = reverse (split(/\//,$filename));
			$interface =~ s/^\s+//g;
			$interface =~ s/\s+$//g;
			if (/Interface/) {
				$exception_hash{$interface}++;
				if ("$interface" ne "$bondedif_hash{$bond}{\"active\"}") {
					$bondedif_hash{$bond}{"passive"} = $interface;
				};
			} elsif (/Active/) {
				$bondedif_hash{$bond}{"active"} = $interface;
			};
		};
	};
};

sub sDoFlips {
	my @print_order = ();
	my @childs = ();

	for my $bond (keys %bondedif_hash) {
		if (($bondedif_hash{$bond}{"active"}) && ($bondedif_hash{$bond}{"passive"})) {

			# print "Flipping $bond from $bondedif_hash{$bond}{\"active\"} to $bondedif_hash{$bond}{\"passive\"}\n";

			`ifenslave -c $bond $bondedif_hash{$bond}{"passive"}`;
			# this will relabel what's active and what is passive
			sGetExceptions();
	
	
			my $cur_if = $bond;
	
			# Need to ask this first here, prior to fork, to store order of interfaces being worked on for easy printout
			# same question is asked again once inside child
			if ((grep(/$cur_if/,@option_ifs)) || ($#option_ifs < 0)) {
				push (@print_order,$cur_if);
			};
	
			if ((grep(/$cur_if/,@option_ifs)) || ($#option_ifs < 0)) {

				$already_seen{$cur_if}++;

				### FORKING CHANGE #######
				# Fork each tshark process so all interfaces are listened to simultaneously and reported on
				my $pid = fork();
				if ($pid) {
					# parent
					push(@childs, $pid);
		
		
				} elsif ($pid == 0) {
					# child
				##########################
	
					my $didclose = 0;
					my $tsharkpid = "";
					eval {
						local $SIG{ALRM} = sub { die "Timeout\n"; };
						# NEEDS to be 125 since there's some unknown buffering which delays the data for 60 seconds
						# and on servers where only the primary packet shows, we need to give it that full 2 minutes
						alarm(125); # 125 seconds
	
						# for ALL doing it this way in order to guarantee we process what we've captured
						if ($option_all) {
							$tsharkpid = open(TSHARK,"$tsharkbin -n -i $cur_if -V '(ether[12:2]=0x88cc or ether[20:2]=0x2000  or (ether host 01:00:0c:cc:cc:cc and ether[20:4]=0x0300000C and ether[24:2]=0x2000)) and not ip' -c $num_packets 2> /dev/null|") || die "Can't open tshark: $!";
						} elsif ($option_cdp) {
							$tsharkpid = open(TSHARK,"$tsharkbin -n -i $cur_if -V '(ether[20:2]=0x2000  or (ether host 01:00:0c:cc:cc:cc and ether[20:4]=0x0300000C and ether[24:2]=0x2000)) and not ip' -c $num_packets 2> /dev/null|") || die "Can't open tshark: $!";
						} elsif ($option_lldp) {
							$tsharkpid = open(TSHARK,"$tsharkbin -n -i $cur_if -V '(ether[12:2]=0x88cc) and not ip' -c $num_packets 2> /dev/null|") || die "Can't open tshark: $!";
						};
						# store the data in the array as it comes in, just in case we time out before 3 packets
						while ($tsharkline = <TSHARK>) {
							if (($tsharkline) && ($tsharkline !~ /Running as/) && ($tsharkline !~ /Capturing/)) {
								chomp($tsharkline);
								push (@if_dpdata,$tsharkline);
								# print "$tsharkline\n";
							};
						};
						close(TSHARK);
						$didclose = 1;

						alarm(0); # turn off the alarm clock
					};	
		
					# if there is an error and there are no Frame's captured
					if (($@) && (! grep(/Frame/,@if_dpdata))) {
						# if we timed out but didn't cleanly close opened pipe, then close it
						# using kill instead of close since close caused delay and also didn't kill all children
						# since open pipe to tshark opened another tshark.bin and then dumpcap, which stayed open for a bit
						# This speeds up when doing sweep 
						if (! $didclose) {
							# close(TSHARK);
							chop(my $tsharkchild = `ps --ppid $tsharkpid | grep -v PID | awk '{print \$1}'`);
							chop(my $tsharkgrandchild = `ps --ppid $tsharkchild | grep -v PID | awk '{print \$1}'`);
							# print "NODATA - killing pid, child, and grandchild - $tsharkpid, $tsharkchild, $tsharkgrandchild \n";
							if ($tsharkgrandchild) { kill 9, $tsharkgrandchild; };
							if ($tsharkchild) { kill 9, $tsharkchild; };
							if ($tsharkpid) { kill 9, $tsharkpid; };
						};
						print "$host,$cur_if,**Data Protocol Not Found - timing out and moving on\n";
					} else {
						# if we timed out but didn't cleanly close opened pipe, then close it
						# using kill instead of close since close caused delay and also didn't kill all children
						# since open pipe to tshark opened another tshark.bin and then dumpcap, which stayed open for a bit
						# This speeds up when doing sweep 
						if (! $didclose) {
							# close(TSHARK);
							chop(my $tsharkchild = `ps --ppid $tsharkpid | grep -v PID | awk '{print \$1}'`);
							chop(my $tsharkgrandchild = `ps --ppid $tsharkchild | grep -v PID | awk '{print \$1}'`);
							# print "NODATA - killing pid, child, and grandchild - $tsharkpid, $tsharkchild, $tsharkgrandchild \n";
							if ($tsharkgrandchild) { kill 9, $tsharkgrandchild; };
							if ($tsharkchild) { kill 9, $tsharkchild; };
							if ($tsharkpid) { kill 9, $tsharkpid; };
						};
						sParseDPData($cur_if,@if_dpdata);
					};
	
				### FORKING CHANGE #######
					exit (0);
				} else {
					die "couldn't fork: $!\n";
				};
				##########################

			};
		};
	
	};

	### FORKING CHANGE #######
	foreach (@childs) {
		waitpid($_,0);
	};
	##########################

	# print all out in order
	for (@print_order) {
		# my @print_tmp = `cat /tmp/$_.dpout |sort -u 2> /dev/null`;
		my @print_tmp = ();
		if (-f "/tmp/$_.dpout") {
			@print_tmp = `cat /tmp/$_.dpout |sort -u 2> /dev/null`;
		};
		print @print_tmp;
	};

	# clean up tmp files
	`rm /tmp/*.dpout 2> /dev/null`;
		
	# Flip back
	for my $bond (keys %bondedif_hash) {
		if (($bondedif_hash{$bond}{"active"}) && ($bondedif_hash{$bond}{"passive"})) {
			# print "Flipping back\n";
			`ifenslave -c $bond $bondedif_hash{$bond}{"passive"}`;
		};
	};
};



sub sGetInterfaces {
	my $if = "";
	my $cur_if = "";
#	my @if_dpdata = ();
	my $tsharkline = "";

	@ifs = `ifconfig -a`;
	for (@ifs) {
		chomp;
		my @if_dpdata = ();
		my ($if,$info) = split(/\s+/,$_,2);
		my ($actualif,$vip) = split(/[:\.]/,$if,2);
		if ($actualif) {
			$cur_if = $actualif;
		};

		# Need to ask this first here, prior to fork, to store order of interfaces being worked on for easy printout
		# same question is asked again once inside child
		if (($cur_if !~ /^lo|^vlan/) && (! $exception_hash{$cur_if}) && (/UP.*RUNNING/) && (! $already_seen{$cur_if}) && ((grep(/$cur_if/,@option_ifs)) || ($#option_ifs < 0))) {
			push (@print_order,$cur_if);
		};

		if (($cur_if !~ /^lo|^vlan/) && (! $exception_hash{$cur_if}) && (/UP.*RUNNING/) && (! $already_seen{$cur_if}) && ((grep(/$cur_if/,@option_ifs)) || ($#option_ifs < 0))) {

			$already_seen{$cur_if}++;

			### FORKING CHANGE #######
			# Fork each tshark process so all interfaces are listened to simultaneously and reported on
			my $pid = fork();
			if ($pid) {
				# parent
				push(@childs, $pid);
	
	
			} elsif ($pid == 0) {
				# child
			##########################

				my $didclose = 0;
				my $tsharkpid = "";
				eval {
					local $SIG{ALRM} = sub { die "Timeout\n"; };
					# NEEDS to be 125 since there's some unknown buffering which delays the data for 60 seconds
					# and on servers where only the primary packet shows, we need to give it that full 2 minutes
					alarm(125); # 125 seconds

					# for ALL doing it this way in order to guarantee we process what we've captured
					if ($option_all) {
						$tsharkpid = open(TSHARK,"$tsharkbin -n -i $cur_if -V '(ether[12:2]=0x88cc or ether[20:2]=0x2000  or (ether host 01:00:0c:cc:cc:cc and ether[20:4]=0x0300000C and ether[24:2]=0x2000)) and not ip' -c $num_packets 2> /dev/null|") || die "Can't open tshark: $!";
					} elsif ($option_cdp) {
						$tsharkpid = open(TSHARK,"$tsharkbin -n -i $cur_if -V '(ether[20:2]=0x2000  or (ether host 01:00:0c:cc:cc:cc and ether[20:4]=0x0300000C and ether[24:2]=0x2000)) and not ip' -c $num_packets 2> /dev/null|") || die "Can't open tshark: $!";
					} elsif ($option_lldp) {
						$tsharkpid = open(TSHARK,"$tsharkbin -n -i $cur_if -V '(ether[12:2]=0x88cc) and not ip' -c $num_packets 2> /dev/null|") || die "Can't open tshark: $!";
					};
					# store the data in the array as it comes in, just in case we time out before 3 packets
					while ($tsharkline = <TSHARK>) {
						if (($tsharkline) && ($tsharkline !~ /Running as/) && ($tsharkline !~ /Capturing/)) {
							chomp($tsharkline);
							push (@if_dpdata,$tsharkline);

							#### FOR TESTING ONLY ##################
							#if ($tsharkline =~ /Arrival Time/) {
							#my $now = `date`;
							#print "=========================\n";
							#print "ACTUAL TIME: $now";
							#print "$tsharkline\n";
							#print "=========================\n";
							#};
							########################################
						};
					};

					close(TSHARK);
					$didclose = 1;
					alarm(0); # turn off the alarm clock
				};	
	
				# if there is an error and there are no Frame's captured
				if (($@) && (! grep(/Frame/,@if_dpdata))) {
					# if we timed out but didn't cleanly close opened pipe, then kill pid, child, and grandchild
					# which are sh -c ... tshark.bin,  tshark.bin and dumpcap
					# This speeds up when doing sweep 
					if (! $didclose) {
						# close(TSHARK);

						chop(my $tsharkchild = `ps --ppid $tsharkpid | grep -v PID | awk '{print \$1}'`);
						chop(my $tsharkgrandchild = `ps --ppid $tsharkchild | grep -v PID | awk '{print \$1}'`);
						# print "NODATA - killing pid, child, and grandchild - $tsharkpid, $tsharkchild, $tsharkgrandchild \n";
						if ($tsharkgrandchild) { kill 9, $tsharkgrandchild; };
						if ($tsharkchild) { kill 9, $tsharkchild; };
						if ($tsharkpid) { kill 9, $tsharkpid; };

					};
					print "$host,$cur_if,**Data Protocol Not Found - timing out and moving on\n";
				} else {
					# if we timed out but didn't cleanly close opened pipe, then close it
					# This speeds up when doing sweep (killing instead of close which caused big delay)
					if (! $didclose) {
						# close(TSHARK);

						chop(my $tsharkchild = `ps --ppid $tsharkpid | grep -v PID | awk '{print \$1}'`);
						chop(my $tsharkgrandchild = `ps --ppid $tsharkchild | grep -v PID | awk '{print \$1}'`);
						# print "DATA - killing pid, child, and grandchild - $tsharkpid, $tsharkchild, $tsharkgrandchild \n";
						if ($tsharkgrandchild) { kill 9, $tsharkgrandchild; };
						if ($tsharkchild) { kill 9, $tsharkchild; };
						if ($tsharkpid) { kill 9, $tsharkpid; };
					};
					sParseDPData($cur_if,@if_dpdata);
				};

			### FORKING CHANGE #######
				exit (0);
			} else {
				die "couldn't fork: $!\n";
			};
			##########################

		};

	};

	### FORKING CHANGE #######
	foreach (@childs) {
		waitpid($_,0);
	};
	##########################

	# print all out in order
	for (@print_order) {
		# my @print_tmp = `cat /tmp/$_.dpout |sort -u 2> /dev/null`;
		my @print_tmp = ();
		if (-f "/tmp/$_.dpout") {
			@print_tmp = `cat /tmp/$_.dpout |sort -u 2> /dev/null`;
		};
		print @print_tmp;
	};

	# clean up tmp files
	`rm /tmp/*.dpout 2> /dev/null`;

};

# Note - come up with way to parse each frame separately and compare the lines, print each entry that's diff
# which will pick up cisco and arista or whatever if both show up
sub sParseDPData {
	my $if = shift;
	my @dpdata = @_;

	my $devid = "";
	my $vlan = "";
	my $vlan_num = "";
	my $portid = "";
	my $portdesc = "";
	my $platform = "";
	my $brand = "";
	my $started = 0;	# keeps track of each frame

	for (@dpdata) {
		chomp;

		# if we see a new frame, if not started, then start, else send info to be printed for that frame
		# and save frame info, so we don't print dups
		if (/^Frame/) {
			if (! $started) {
				$started = 1;
			} else {
				# sPrintFrame($if,$devid,$vlan_num,$portid,$portdesc,$platform,$brand,@dpdata);

				# if the device id isn't the host itself
				# (This is done since on rare occasions an lldp packet will come from the host itself
				#  if a specific network service is left on. We only want switch data.)
				if ($devid !~ /^$host\./) {
					sPrintFrame($if,$devid,$vlan_num,$portid,$portdesc,$platform,$brand,@dpdata);
				};

				# reset vars
			        my $devid = "";
			        my $vlan = "";
			        my $vlan_num = "";
			        my $portid = "";
			        my $portdesc = "";
			        my $platform = "";
				my $brand = "";
			};
		};

		if ((/System Name =/) || (/Device ID:/)) {
			($label,$devid) = split(/[:=]/,$_,2);
			$devid = sStripExtraSpaces($devid);
		} elsif (/Native VLAN:/) {
			($label,$vlan) = split(/:/,$_,2);
			$vlan_num = sStripExtraSpaces($vlan);
		} elsif (/Port VLAN Identifier:/) {
			($label,$vlan) = split(/:/,$_,2);
			$vlan = sStripExtraSpaces($vlan);
			($vlan_num,$vlan_hex) = split(/\s+/,$vlan,2);
		} elsif (((/Port ID:/) || (/Port Id:/)) && (! /Aggregated/)) {
			($label,$portid) = split(/:/,$_,2);
			$portid = sStripExtraSpaces($portid);
		} elsif (/Port Description:/) {
			($label,$portdesc) = split(/:/,$_,2);
			$portdesc = sStripExtraSpaces($portdesc);
		} elsif (/Platform:/) {
			($label,$platform) = split(/:/,$_,2);
			$platform = sStripExtraSpaces($platform);
		} elsif (/System Description/) {
			my ($label,$sysdesc) = split(/=/,$_,2);
			($junk,$platform,$junk2) = split(/running on an |\,/,$sysdesc,3);
			$platform = sStripExtraSpaces($platform);
		};
		# find the brand
		if (/Arista/) {
			$brand = "Arista";
		} elsif (/Cisco/) {
			$brand = "Cisco";
		};
	};
	# on last frame, need to print here as well
	# sPrintFrame($if,$devid,$vlan_num,$portid,$portdesc,$platform,$brand,@dpdata);

	# if the device id isn't the host itself
	# (This is done since on rare occasions an lldp packet will come from the host itself
	#  if a specific network service is left on. We only want switch data.)
	if ($devid !~ /^$host\./) {
		sPrintFrame($if,$devid,$vlan_num,$portid,$portdesc,$platform,$brand,@dpdata);
	};
};

sub sPrintFrame {
	my $if = shift;
	my $devid = shift;
	my $vlan_num = shift;
	my $portid = shift;
	my $portdesc = shift;
	my $platform = shift;
	my $brand = shift;
	# my @dpdata = @_;

	# in some cases (Cisco using LLDP), the port description is where port id info is shown
	# if there's info under port description and not under port id, assign the description as the port id
	# if both exist, and the port description has something more than just host and interface name, display both
	if (($portdesc) && (! $portid)) {
		$portid = $portdesc;
	} elsif ((($portdesc) && ($portid)) && ($portdesc !~ /$host.*$if/)) {
		$portid = "$portid" . "($portdesc)";
	};

	# store output in tmp files since each forked child will finish at different times and we want consistent output for easy checks
	if (-e "/tmp/$if.dpout") {
		open (TMPOUT,">>/tmp/$if.dpout") || die "Can't open /tmp/$if.out : $!";
	} else {
		open (TMPOUT,">/tmp/$if.dpout") || die "Can't open /tmp/$if.out : $!";
	};

	# if not printed before, go and print
	# if we know it's arista add that information
	my $printed_text = "$host-$if-$devid-$portid-$vlan_num-$platform";
	$printed_text =~ s/\s+/_/g;
	if (! $printed_dpscan{$printed_text}) {
		$printed_dpscan{$printed_text}++;

		# ADDED IN mac/ip info
		my $ip = $interfaces_hash{$if}{"ip"};

		# if interface is a bond, at this point we can add which is the active slave into the name for printing
		if ($bondedif_hash{$if}{"active"}) {
			my $mac = $interfaces_hash{$bondedif_hash{$if}{"active"}}{"hwaddr"};
		        $if = "$if($bondedif_hash{$if}{\"active\"}),$ip,$mac";
		} else {
			my $mac = $interfaces_hash{$if}{"hwaddr"};
		        $if = "$if,$ip,$mac";
		};


		if ($brand =~ /Arista/) {
			# if we found a specific model, then show that
			if ($platform) {
				# print to stdout will yield random orders when all ifs are forked to scan at same time
				#print "$host,$if,$devid,$portid,$vlan_num,Arista ($platform)\n";
				print TMPOUT "$host,$if,$devid,$portid,$vlan_num,Arista ($platform)\n";
			} else {
				# print to stdout will yield random orders when all ifs are forked to scan at same time
				#print "$host,$if,$devid,$portid,$vlan_num,Arista\n";
				print TMPOUT "$host,$if,$devid,$portid,$vlan_num,Arista\n";
			};
		} elsif ($brand =~ /Cisco/) {
			if ($platform) {
				# print to stdout will yield random orders when all ifs are forked to scan at same time
				#print "$host,$if,$devid,$portid,$vlan_num,Cisco ($platform)\n";
				print TMPOUT "$host,$if,$devid,$portid,$vlan_num,Cisco ($platform)\n";
			} else {
				# print to stdout will yield random orders when all ifs are forked to scan at same time
				#print "$host,$if,$devid,$portid,$vlan_num,Cisco\n";
				print TMPOUT "$host,$if,$devid,$portid,$vlan_num,Cisco\n";
			};
		} else {
			# print to stdout will yield random orders when all ifs are forked to scan at same time
			#print "$host,$if,$devid,$portid,$vlan_num,$platform\n";
			print TMPOUT "$host,$if,$devid,$portid,$vlan_num,$platform\n";
		};
	};

	close(TMPOUT);

};

sub sStripExtraSpaces {
        my $inline = shift;
        $inline =~ s/^\s+//;
        $inline =~ s/\s+$//;
        $inline =~ s/\s+/ /;
        return $inline;
};


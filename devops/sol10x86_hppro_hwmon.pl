#!/opt/gsperl-5.8.6_1/bin/perl 
#******************************************************************************
# @(#) hppro_hwmon: collect HW events from HP Proliant Utilities 
# @(#) Copyright (C) 2006 by KUDOS BVBA <info@kudos.be>.  All rights reserved.
# @(#) $Id: hppro_hwmon,v 1.9 2008/08/20 20:46:47 patrick Exp $
# @(#) vim: set et ts=4 sw=4 ffs=unix:
#******************************************************************************
# This program is a free software; you can redistribute it and/or modify
# it under the same terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details
#******************************************************************************

#******************************************************************************
# DATA structures
#******************************************************************************

use strict;
use warnings;
use Switch;
# -------------------- configuration starts here ------------------------------
# define which HP utility commands to run (customize where necessary)
my %commands = ('asm_asr' => '/opt/HPQhealth/sbin/hpasmcli -s "SHOW ASR"', 'asm_boot' => '/opt/HPQhealth/sbin/hpasmcli -s "SHOW BOOT"', 'asm_dimm' => '/opt/HPQhealth/sbin/hpasmcli -s "SHOW DIMM"', 'asm_fans' => '/opt/HPQhealth/sbin/hpasmcli -s "SHOW F1"', 'asm_fans' => '/opt/HPQhealth/sbin/hpasmcli -s "SHOW FANS"', 'asm_ht' => '/opt/HPQhealth/sbin/hpasmcli -s "SHOW HT"', 'asm_iml' => 'yes | /opt/HPQhealth/sbin/hpasmcli -s "SHOW IML"', 'asm_ipl' => '/opt/HPQhealth/sbin/hpasmcli -s "SHOW IPL"', 'asm_name' => '/opt/HPQhealth/sbin/hpasmcli -s "SHOW NAME"', 'asm_power' => '/opt/HPQhealth/sbin/hpasmcli -s "SHOW POWERSUPPLY"', 'asm_pxe' => '/opt/HPQhealth/sbin/hpasmcli -s "SHOW PXE"', 'asm_serial_bios' => '/opt/HPQhealth/sbin/hpasmcli -s "SHOW SERIAL BIOS"', 'asm_serial_embedded' => '/opt/HPQhealth/sbin/hpasmcli -s "SHOW SERIAL EMBEDDED"', 'asm_serial_virtual' => '/opt/HPQhealth/sbin/hpasmcli -s "SHOW SERIAL VIRTUAL"', 'asm_server' => '/opt/HPQhealth/sbin/hpasmcli -s "SHOW SERVER"', 'asm_temperature' => '/opt/HPQhealth/sbin/hpasmcli -s "SHOW TEMP"', 'asm_uid' => '/opt/HPQhealth/sbin/hpasmcli -s "SHOW UID"', 'asm_wol' => '/opt/HPQhealth/sbin/hpasmcli -s "SHOW WOL"', 'acu_controller' => '/opt/HPQacucli/sbin/hpacucli controller all show status', 'acu_physical_drive' => '/opt/HPQacucli/sbin/hpacucli controller slot=0 physicaldrive all show status', 'acu_logical_drive' => '/opt/HPQacucli/sbin/hpacucli controller slot=0 logicaldrive all show status');
my $host = `hostname`;
my $date = `date '+%d-%b-%Y'`;
# mail settings
my @recipients = ('foo@bar.com');
my $subject = 'HP Proliant hardware event report';
my $mailer = '/bin/mail';
my $notice = "Please check the conditions of the following hardware components. These raised an unexpected event during the run of the script: $0";
# --------------------- configuration ends here -------------------------------
my $report;
my %fragments;


#******************************************************************************
# SUBroutines
#******************************************************************************

# execute commands
sub execute_commands {
	my $check = '';;
	my %output = ();
	foreach (sort keys (%commands)) {
		$output{$_} .= "[$_]\n";
        $output{$_} .= "=> command executed: $commands{$_}\n";
		$check = qx($commands{$_});
        if ($? & 127) {
            $output{$_} .= "ERROR: Unable to execute utility command!\n";
        } else {
		    $output{$_} .= $check;
        }
	}
	return %output;
}

# parse 'asm_fans' fragment for events
sub parse_fragment_asm_fans {
    my $fragment = $_[0];
    my @fragment = ();
    @fragment = split (/\n/, $fragment);
    foreach (@fragment) {
       return $fragment if m/^(normal)/ig;
    }
}

# parse 'asm_dimm' fragment for events
sub parse_fragment_asm_dimm {
    my $fragment = $_[0];
    my @fragment = ();
    @fragment = split (/\n/, $fragment);
    foreach (@fragment) {
       return $fragment if m/(nok|fail)/ig;
    }
}

# parse 'asm_power' fragment for events
sub parse_fragment_asm_power {
    my $fragment = $_[0];
    my @fragment = ();
    @fragment = split (/\n/, $fragment);
    foreach (@fragment) {
       return $fragment if m/(nok|fail)/ig;
    }
}

# parse 'asm_server' fragment for events
sub parse_fragment_asm_server {
    my $fragment = $_[0];
    my @fragment = ();
    @fragment = split (/\n/, $fragment);
    foreach (@fragment) {
       return $fragment if m/(nok|fail)/ig;
    }
}

# parse 'asm_temperature' fragment for events
sub parse_fragment_asm_temperature {
    my $fragment = $_[0];
    my @fragment = ();
    @fragment = split (/\n/, $fragment);
    foreach (@fragment) {
        my $temp = '';
        my $threshold = '';
        # match numerical sensor lines only
        if (m/^#[0-9]/) {
            my @line = split (/\s+/, $_);
            my @field = split (/\//, $line[2]);
            # get Celsius value
            $temp = $field[0];
            $temp =~ s/C//;
            @field = split (/\//, $line[3]);
            # get Celsius value
            $threshold = $field[0];
            $threshold =~ s/C//;
            # skip bogus values
            unless ($temp =~ /-/) {
                return $fragment if (int($temp) > int($threshold));
            }
        } else {
            next;
        }
    }
}

# parse 'acu_controller' fragment for events
sub parse_fragment_acu_controller {
    my $fragment = $_[0];
    my @fragment = ();
    @fragment = split (/\n/, $fragment);
    foreach (@fragment) {
       return $fragment if m/(nok|fail)/ig;
    }
}

# parse 'acu_physical_drive' fragment for events
sub parse_fragment_acu_physical_drive {
    my $fragment = $_[0];
    my @fragment = ();
    @fragment = split (/\n/, $fragment);
    foreach (@fragment) {
       return $fragment if m/(nok|fail)/ig;
    }
}

# parse 'acu_logical_drive' fragment for events
sub parse_fragment_acu_logical_drive {
    my $fragment = $_[0];
    my @fragment = ();
    @fragment = split (/\n/, $fragment);
    foreach (@fragment) {
       return $fragment if m/(nok|fail)/ig;
    }
}

# mail report
sub mail_report {
    my $report = $_[0];
    my $full_subject = "$subject on $host at $date";
    $report = $notice."\n\n".$report;
    foreach (@recipients) {
        system ("echo \"$report\" | $mailer -s \"$full_subject\" $_");
        if ($? gt 0) {
            die "ERROR: failed to send event report to $_ (code: $?)";
        } else {
            print "INFO: mailed event report to $_\n";
        }
    }
}

# print report
sub print_report {
	my %output = %{$_[0]};
	foreach (sort keys (%output)) {
		print "$output{$_}\n";
	}
    return (0);
}

# print usage
sub print_usage {
	print "** hppro_hwmon: HP Proliant HW monitor <info\@kudos.be> **\n".
		"Command-line parameters:\n".
		"\t-c perform checks and send email on alert/error\n".
		"\t-s show checks and output on STDOUT\n\n".
		"This script uses HP utilities such as hpasmcli, hpacucli etc\n";
	return (0);
}


#******************************************************************************
# MAIN routine
#******************************************************************************

if ($#ARGV < 0 or $#ARGV > 0) {
	die "ERROR: either specify '-s' or '-c' as parameter\n";
}
if ($ARGV[0] eq '-c') {
    %fragments = execute_commands ();
    # check the output for each collected fragment
    foreach (sort keys (%fragments)) {
        my $check = '';
        switch ($_) {
            case 'asm_fans'             { $check = parse_fragment_asm_fans ($fragments{$_}); }
            case 'asm_dimm'             { $check = parse_fragment_asm_dimm ($fragments{$_}); }
            case 'asm_power'            { $check = parse_fragment_asm_power ($fragments{$_}); }
            case 'asm_server'           { $check = parse_fragment_asm_server ($fragments{$_}); }
            case 'asm_temperature'      { $check = parse_fragment_asm_temperature ($fragments{$_}); }
            case 'acu_controller'       { $check = parse_fragment_acu_controller ($fragments{$_}); }
            case 'acu_physical_drive'   { $check = parse_fragment_acu_physical_drive ($fragments{$_}); }
            case 'acu_logical_drive'    { $check = parse_fragment_acu_logical_drive ($fragments{$_}); }
        } 
        $report .= $check if ($check);
    }
    # if the collected report is not empty then mail the results
    if ($report) {
        print "WARNING: found hardware alarm events!\n";
        mail_report ($report);
		exit (1);
    } else {
        print "INFO: no hardware alarm events found! Be happy :)\n";
		exit (0);
    }
} elsif ($ARGV[0] eq '-s') {
    %fragments = execute_commands ();
    print_report (\%fragments);
} else {
    &print_usage ();
}
exit (0);

#******************************************************************************
# END of script
#******************************************************************************

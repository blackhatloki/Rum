#!/usr/bin/perl -w
# Template for Perl Toolkit scripts


# Import runtime libraries
use strict;
use warnings;
use VMware::VIRuntime;
use VMware::VILib;


# Read and validate command-line parameters
Opts::parse();
Opts::validate();


# Connect to the server and login
Util::connect();

my $List2d = GetVmByName('DEV$');
PrintVmsOnNetwork($List2d,'Production_LAN');


# Close server connection
Util::disconnect();

##############################################################################

sub PrintVmsOnNetwork {
   my $vms = shift;
   my $network = shift;

   print "Network:" . $network . "\n";

   foreach my $vm (@$vms) {
      my $vnics = 
         Vim::get_views(
            mo_ref_array => $vm->network
         );
      foreach my $vnic (@$vnics) {
         if( $vnic->name eq $network ) {
            print "  Virtual machine " . $vm->name . "\n";
         }
      }
   }
}

sub GetVmByName {
  my $vmname  = shift;

  return Vim::find_entity_views(
               view_type => 'VirtualMachine',
               filter => {
                  name => qr/$vmname/i
               }
  );
}

# Copyright 2008 VMware, Inc.  All rights reserved.

########################################################################################
# DISCLAIMER. THIS SCRIPT IS PROVIDED TO YOU "AS IS" WITHOUT WARRANTIES OR CONDITIONS 
# OF ANY KIND, WHETHER ORAL OR WRITTEN, EXPRESS OR IMPLIED. THE AUTHOR SPECIFICALLY 
# DISCLAIMS ANY IMPLIED WARRANTIES OR CONDITIONS OF MERCHANTABILITY, SATISFACTORY 
# QUALITY, NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR PURPOSE. 
########################################################################################


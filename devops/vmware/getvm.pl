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

# Add your code here
my $List2a = GetVm();
PrintVmPowerState($List2a);

# Close server connection
Util::disconnect();

##############################################################################

sub GetVm {
   return Vim::find_entity_views(
             view_type => 'VirtualMachine'
  );
}

sub PrintVmPowerState {
   my $vms = shift;
   foreach my $vm (@$vms) {
      print "Virtual machine " . 
      $vm->name . " power state is: " . 
      $vm->runtime->powerState->val . "\n";
   }
}

# Copyright 2008 VMware, Inc.  All rights reserved.

########################################################################################
# DISCLAIMER. THIS SCRIPT IS PROVIDED TO YOU "AS IS" WITHOUT WARRANTIES OR CONDITIONS 
# OF ANY KIND, WHETHER ORAL OR WRITTEN, EXPRESS OR IMPLIED. THE AUTHOR SPECIFICALLY 
# DISCLAIMS ANY IMPLIED WARRANTIES OR CONDITIONS OF MERCHANTABILITY, SATISFACTORY 
# QUALITY, NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR PURPOSE. 
########################################################################################

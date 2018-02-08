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

my $List2e = GetVmHost("vmw9-1-esx$ENV{labID}");
PrintHost($List2e);

# Close server connection
Util::disconnect();

##############################################################################

sub GetVmHost {
   my $host = shift;
   return Vim::find_entity_view(
             view_type => 'HostSystem',
             filter => {
                name => qr/$host/i
             }
          );
}

sub PrintHost {
   my $host = shift;
   my $product = $host->summary->config->product;
   print "Host: ",$host->name,"\n";
   print "\tVersion: ",$product->version,"\n";
   print "\tBuild: ",$product->build,"\n";
   print "\tVMotion Enabled: ",$host->summary->config->vmotionEnabled,"\n";
}

# Copyright 2008 VMware, Inc.  All rights reserved.

########################################################################################
# DISCLAIMER. THIS SCRIPT IS PROVIDED TO YOU "AS IS" WITHOUT WARRANTIES OR CONDITIONS 
# OF ANY KIND, WHETHER ORAL OR WRITTEN, EXPRESS OR IMPLIED. THE AUTHOR SPECIFICALLY 
# DISCLAIMS ANY IMPLIED WARRANTIES OR CONDITIONS OF MERCHANTABILITY, SATISFACTORY 
# QUALITY, NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR PURPOSE. 
########################################################################################


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

my $List4a = GetVmHosts('');
GetLogType($List4a);

# Close server connection
Util::disconnect();

##############################################################################

sub GetVmHosts {
   my $name = shift;
   return Vim::find_entity_views(
             view_type => 'HostSystem',
             filter => {
                name => qr/$name/i
             }
          );
}

sub GetLogType {
   my $hosts = shift;
   my $service_content = Vim::get_service_content();
   my $diagMgr =
      Vim::get_view(
         mo_ref => 
            $service_content->diagnosticManager
      );

   foreach my $host (@$hosts) {
      my $hostname = $host->name;
      print "\nHost: $hostname\n";

      my $logs = 
         $diagMgr->QueryDescriptions(
            host => $host
         );
  
      foreach my $log(@{$logs}) {
         print $log->key,
            "\t",$log->format,"\n";
      }
   }
}

# Copyright 2008 VMware, Inc.  All rights reserved.

########################################################################################
# DISCLAIMER. THIS SCRIPT IS PROVIDED TO YOU "AS IS" WITHOUT WARRANTIES OR CONDITIONS 
# OF ANY KIND, WHETHER ORAL OR WRITTEN, EXPRESS OR IMPLIED. THE AUTHOR SPECIFICALLY 
# DISCLAIMS ANY IMPLIED WARRANTIES OR CONDITIONS OF MERCHANTABILITY, SATISFACTORY 
# QUALITY, NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR PURPOSE. 
########################################################################################


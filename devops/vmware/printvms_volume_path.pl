#!/usr/bin/perl -w
#
# Copyright (c) 2007 VMware, Inc.  All rights reserved.

use strict;
use warnings;


use VMware::VIRuntime;
use VMware::VILib;


$SIG{__DIE__} = sub{Util::disconnect()};
$Util::script_version = "1.0";


Opts::parse();
Opts::validate();

Util::connect();

my $vmlist = GetVm();

PrintVms_Volume_Path($vmlist);

Util::disconnect();

# Gets  a list of Virtual Machines on the server
sub GetVm {
   my $vms = 
      Vim::find_entity_views(view_type => 
         'VirtualMachine');
}

# Iterates the Virtual Machines, prints the name of the guest os, 
# path to the vmdk on each virtual machine and capacity of the 
# virtual disk

sub PrintVms_Volume_Path {
   my $vms = $vmlist;
   
   Util::trace(0,"Listing Vms\n\n");
   foreach my $vm (@$vms) {
      my $cnt = 0;
      Util::trace(0, "\n\nVirtual machine " . $vm->name ."\n ");
      my $len =  @{$vm->config->hardware->device};
      while($cnt<$len)
      {
         my $device_info_label = $vm->config->hardware->device->[$cnt]->deviceInfo->label;
         if($device_info_label =~ m/Hard Disk/){
            if(defined ($vm->config->hardware->device->[$cnt]->capacityInKB)){
               Util::trace(0,"\n" . $device_info_label . " " . $vm->config->hardware->device->[$cnt]->capacityInKB." KB");
               Util::trace(0,"\nBacking Info: ". $vm->config->hardware->device->[$cnt]->backing->fileName);
            }
         }
         $cnt++;
      }#end-of-while
   }#end of for
}#end of sub


# Copyright 2008 VMware, Inc.  All rights reserved.

########################################################################################
# DISCLAIMER. THIS SCRIPT IS PROVIDED TO YOU "AS IS" WITHOUT WARRANTIES OR CONDITIONS 
# OF ANY KIND, WHETHER ORAL OR WRITTEN, EXPRESS OR IMPLIED. THE AUTHOR SPECIFICALLY 
# DISCLAIMS ANY IMPLIED WARRANTIES OR CONDITIONS OF MERCHANTABILITY, SATISFACTORY 
# QUALITY, NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR PURPOSE. 
########################################################################################



__END__

=head1 NAME

7a.pl -  List Virtual Machines, information about their VMDK files, information about guest OS volumes

=head1 SYNOPSIS

7a.pl [options]

=head1 DESCRIPTION

This VI Perl command-line utility provides an interface to lists
virtual machines, information about their vmdk files, information
about guest os volumes

=back

=head1 EXAMPLES

List all the virtual machines and information of their vmdk files

 7a.pl --url https://<host>:<port>/sdk/vimService
                --username myuser --password mypassword
                
=head1 SUPPORTED PLATFORMS

All operations work with VMware VirtualCenter 2.0.1 or later.

All operations work with VMware ESX Server 3.0.1 or later.


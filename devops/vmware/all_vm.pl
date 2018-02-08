#!/usr/bin/perl -w
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
my $vmlist = GetVm();
PrintVmPowerState($vmlist);
Util::disconnect();

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

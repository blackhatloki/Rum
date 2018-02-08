#!/usr/bin/perl -w
use strict;
use warnings;

use VMware::VIRuntime;

my %opts = (
   'entitytype' => {
      type => "=s",
      help => "Entity Type [HostSystem | VirtualMachine]",
      required => 1,
   },
   'entityname' => {
      type => "=s",
      help => "Name of the Entity",
      required => 1,
   },
   'user' => {
      type => "=s",
      help => "User with the domain name",
      required => 1,
   },
   'operation' => {
      type => "=s",
      help => "Operation that can be performed on the virtual machine",
      required => 1,
   },
);

# read/validate options and connect to the server 
Opts::add_options(%opts);
Opts::parse();
Opts::validate();

Util::connect();

my $entitytype = Opts::get_option('entitytype');
my $entityname = Opts::get_option('entityname');
my $user = Opts::get_option('user');
my $operation = Opts::get_option('operation');

my $entity_view = Vim::find_entity_view(view_type => $entitytype,
                                        filter => { 'name' => $entityname});

if (!$entity_view) {
   Util::trace(0, "\nThe " . $entitytype . $entityname . " is not present in the inventory\n");
   return;
}

checkPermission($user, $entity_view, $operation);
Util::disconnect();

sub checkPermission {

   my ($user, $entity_view, $operation) = @_;

   my $has_privilege = 0;
   my $service_content = Vim::get_service_content();
   my $authorizationManager = $service_content->authorizationManager;
   my $authorizationManager_view = Vim::get_view(mo_ref => $authorizationManager);
   my $permissions = $authorizationManager_view->RetrieveEntityPermissions
                                                (entity=>$entity_view,
                                                inherited=>'true');
   my $roleList = $authorizationManager_view->roleList;

   foreach (@$permissions) {
      if ($user eq $_->principal) {
         my $entity_roleId = $_->roleId;
         foreach (@$roleList) {
            if ($_->roleId eq $entity_roleId) {
               my $privilege = $_->privilege;
               foreach (@$privilege) {
                  if ($_ eq $operation) {
                    print "\nUser " . $user . " has the privilege to perform " .
                          "the " . $operation . " operation on " . $entity_view->name . "\n";
                     $has_privilege = 1;
                  }
               }
            }
         }
      }
   }

   if ($has_privilege eq 0) {
      print "\nUser " . $user . " does not have the privilege to perform the " . 
            $operation . " operation on " . $entity_view->name . "\n";
   }
}

# Copyright 2008 VMware, Inc.  All rights reserved.

########################################################################################
# DISCLAIMER. THIS SCRIPT IS PROVIDED TO YOU "AS IS" WITHOUT WARRANTIES OR CONDITIONS 
# OF ANY KIND, WHETHER ORAL OR WRITTEN, EXPRESS OR IMPLIED. THE AUTHOR SPECIFICALLY 
# DISCLAIMS ANY IMPLIED WARRANTIES OR CONDITIONS OF MERCHANTABILITY, SATISFACTORY 
# QUALITY, NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR PURPOSE. 
########################################################################################


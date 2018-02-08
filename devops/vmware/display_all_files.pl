#!/usr/bin/perl -w
#
# Copyright (c) 2007 VMware, Inc.  All rights reserved.

use strict;
use warnings;


use VMware::VIRuntime;
use VMware::VILib;


$SIG{__DIE__} = sub{Util::disconnect()};
$Util::script_version = "1.0";


my %opts = (
 name => {
      type => "=s",
      help => "Name of the Datastore",
      required => 0,
   },
);

Opts::add_options(%opts);
Opts::parse();
Opts::validate();

Util::connect();

my $datastores = find_datastores();
if (@$datastores) {
   browse_datastore($datastores);
}
else {
   Util::trace(0, "\nNo Datastores Found\n");
}

Util::disconnect();

sub browse_datastore {
   my ($datastores) = @_;
   foreach my $datastore (@$datastores) {
      display_info($datastore);
      display_all_files($datastore);
   }
   Util::trace(0, "\n\n");
}

#Invokes SearchDatastoreSubFolders to search for files on the datastore
#and displays the path to the files 
sub print_browse {
   my %args = @_;
   my $datastore_mor = $args{mor};
   my $path = $args{filePath};
   my $browse_task;
   eval {
      $browse_task = $datastore_mor->SearchDatastoreSubFolders(datastorePath=>$path);
   };
   if ($@) {
      Util::trace(0, "\nError occured : ");
      if (ref($@) eq 'SoapFault') {
         if (ref($@->detail) eq 'FileNotFound') {
            Util::trace(0, "The file or folder specified by "
                         . "datastorePath is not found");
         }
         elsif (ref($@->detail) eq 'InvalidDatastore') {
            Util::trace(0, "Operation cannot be performed on the target datastores");
         }
         else {
            Util::trace(0, "\n" . $@ . "\n");
         }
      }
      else {
         Util::trace(0, "\n" . $@ . "\n");
      }
   }
   foreach(@$browse_task) {
     if(defined $_->file) {
         Util::trace(0,"\n Files present \n");
         foreach my $x (@{$_->file}) {
            Util::trace(0,"  " . $x->path . "\n");
         }
      }
   }
}

#Gets a list of datastores or the specified datastore
sub find_datastores {

   my $dc = Vim::find_entity_views(view_type => 'Datacenter');
   my @ds_array = ();
   foreach(@$dc) {
      if(defined $_->datastore) {
         @ds_array = (@ds_array, @{$_->datastore});
      }
   }

   my $datastores = Vim::get_views(mo_ref_array => \@ds_array);
   @ds_array = ();
   foreach(@$datastores) {
      if($_->summary->accessible) {
         @ds_array = (@ds_array, $_);
      }
   }
   return \@ds_array;
}


#Prints Datastore's information like it's location, 
#freespace and max file size
sub display_info {
   my ($datastore) = @_;
   if($datastore->summary->accessible) {
      Util::trace(0,"\n\nDatastore Name : '"
               . $datastore->summary->name . "'");
      Util::trace(0,"\n---------------------------");
      Util::trace(0,"\n URL         : " . $datastore->info->url);
      Util::trace(0,"\n Free Space         : " . $datastore->info->freeSpace);
      Util::trace(0,"\n Max File Size         : " . $datastore->info->maxFileSize);
   }
   else {
      Util::trace(0, "\nDatastore summary not accessible\n");
   }
}

#Prints all the files on the datastore
sub display_all_files {
   my ($datastore) = @_;
   Util::trace(0,"\n\nDatastore Files");
   my $host_data_browser = Vim::get_view(mo_ref => $datastore->browser);
   print_browse(mor => $host_data_browser,
                filePath => '[' . $datastore->summary->name . ']',
                level => 0);
}

# Copyright 2008 VMware, Inc.  All rights reserved.

########################################################################################
# DISCLAIMER. THIS SCRIPT IS PROVIDED TO YOU "AS IS" WITHOUT WARRANTIES OR CONDITIONS 
# OF ANY KIND, WHETHER ORAL OR WRITTEN, EXPRESS OR IMPLIED. THE AUTHOR SPECIFICALLY 
# DISCLAIMS ANY IMPLIED WARRANTIES OR CONDITIONS OF MERCHANTABILITY, SATISFACTORY 
# QUALITY, NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR PURPOSE. 
########################################################################################

__END__

=head1 NAME

7b.pl - Browse datastores and list their attributes.

=head1 SYNOPSIS

 7b.pl [options]

=head1 DESCRIPTION

This VI Perl command-line utility provides an interface to browse
datastores and list attributes of datastores and all files in the 
datstores.

=head1 OPTIONS

=head2 GENERAL OPTIONS

=over

=item B<name>

Optional. Name of the datastore.

=back

=head1 EXAMPLES

List all the datastores and all files on them

7b.pl --url https://<host>:<port>/sdk/vimService
                --username myuser --password mypassword
                

List all files for datastore 'Data123'

 7b.pl --url https://<host>:<port>/sdk/vimService
                --username myuser --password mypassword
                --name Data123

=head1 SUPPORTED PLATFORMS

All operations work with VMware VirtualCenter 2.0.1 or later.

All operations work with VMware ESX Server 3.0.1 or later.


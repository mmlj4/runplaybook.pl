#!/usr/bin/perl -w

# File: runplaybook.pl
# Version 1.1
# Copyright Joey Kelly (joeykelly.net)
# February 1, 2016
# License: GPL version 2
#
# This is a simple Perl wrapper script to run a generic Ansible playbook against an arbitrary host or defined group of hosts.
# In your playbook, substitute the '{{ hosts }}' target for hosts, and use that as a variable later on as needed.
#
# Example:
#
# root@wildebeest:# cat pingtest.yaml
# ---
# - hosts: '{{ hosts }}'
#   remote_user: root
#   tasks:
#   - name: test connection
#     ping:
#     remote_user: root
#

use strict;

my $thisscript = 'runplaybook.pl';

my $playbook = shift || '';
my $host = shift || '';
my $verbose = shift || '';

# lose any bad characters, just to be safe
$playbook = safechars($playbook);
$host = safechars($host);
$verbose = safechars($verbose);

$verbose = '' unless $verbose eq '-v';

if ($playbook && $host) {
#my $run = "ansible-playbook $playbook --extra-vars=hosts=$host";
my $run = "ansible-playbook $verbose $playbook --extra-vars=hosts=$host";
  print "running: $run\n";
  system $run;
} else {
  print "usage: ./$thisscript playbook host [-v]\n";
}

sub safechars {
  my $string = shift;
  $string =~ tr/a-zA-Z0-9\._-//dc;
  return $string;
}

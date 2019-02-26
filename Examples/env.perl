#!/usr/bin/perl -w
use strict;
use warnings;
# $Id: env.perl,v 1.1 2014-10-03 16:57:20-07 - - $
#
# NAME
#    env.perl - print out process environment variables
#

for my $var (sort keys %ENV) {
   print "$var => $ENV{$var}\n";
};

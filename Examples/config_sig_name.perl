#!/usr/bin/perl
# $Id: config_sig_name.perl,v 1.1 2014-10-03 16:57:20-07 - - $

use strict;
use warnings;
use Config;
defined $Config{sig_name} or die "No Config{sig_name}!\n";

my @sig_names = map {"SIG$_"} split ' ', $Config{sig_name};

print "SIG[$_]=$sig_names[$_]\n" for 0..$#sig_names;

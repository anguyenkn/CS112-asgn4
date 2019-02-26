#!/usr/bin/perl
# $Id: xref.perl,v 1.1 2014-10-03 16:57:20-07 - - $

map { $hash{lc $_} .= " $." } m/(\w+)/g while <>;
map { print "$_$hash{$_}\n" } sort keys %hash;


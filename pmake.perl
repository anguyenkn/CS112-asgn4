#!/usr/bin/perl -w
use strict;
use warnings;

#from getopts.perl
use Getopt::Std;
my %OPTS;
getopts("d", \%OPTS);

# init filename if theres no file then filename will be set to Makefile
my $filename = "Makefile";
$filename = $ARGV[0] if exists $ARGV[0];

# debugging information
print "filename: $filename\n" if $OPTS{'d'};

# from cat.perl
open my $infile, "<$filename" or warn "<$filename: $!\n" and next;
while (defined (my $line = <$infile>)) {
    chomp $line;
    # (m) is the match operator || capture groups
    # makefile syntax if # (comment) ignore
    next if $line =~ m/^\s*#/;
    # if macro = value -> put into hashtable (\S+) is the regex pattern to get macro val
    if ($line =~ m/\s*(\S+)\s*=\s+(.+)/) {

    }
    # target ... : prereq
    elsif ($line =~ m/\s*(\S+)\s*:.*/) {

    }
    # command (\t)
    elsif ($line =~ m/\t\s*(.+)/) {

    }

}
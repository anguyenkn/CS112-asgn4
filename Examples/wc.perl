#!/usr/bin/perl -w
use strict;
use warnings;
my $RCSID = '$Id: wc.perl,v 1.1 2014-10-03 16:57:20-07 - - $';

$0 =~ s|^(.*/)?([^/]+)/*$|$2|;
my $EXITCODE = 0;
END{ exit $EXITCODE; }
sub note(@){ print STDERR "$0: @_"; };
$SIG{'__WARN__'} = sub{ note @_;; $EXITCODE = 1; };
$SIG{'__DIE__'} = sub{ warn @_; exit; };

use Getopt::Std;
my %OPTIONS;
getopts ("cwl", \%OPTIONS);
%OPTIONS = qw(c 1 w 1 l 1) unless %OPTIONS;

push @ARGV, "-" unless @ARGV;

for my $filename (@ARGV) {
   open my $file, $filename or warn "$filename: $!\n" and next;
   my $linect = 0;
   my $wordct = 0;
   my $charct = 0;
   while (defined (my $line = <$file>)) {
      $linect += 1;
      my @words = $line =~ m/(\S+)/;
      $wordct += @words;
      $charct += length $line;
   };
   printf " %7d", $linect if $OPTIONS{'l'};
   printf " %7d", $wordct if $OPTIONS{'w'};
   printf " %7d", $charct if $OPTIONS{'c'};
   printf " %s\n", $filename;
   close $file;
};


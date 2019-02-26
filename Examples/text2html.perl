#!/usr/bin/perl -w
use strict;
use warnings;
my $RCSID = '$Id: text2html.perl,v 1.1 2014-10-03 16:57:20-07 - - $';

$0 =~ s|^(.*/)?([^/]+)/*$|$2|;
my $EXITCODE = 0;
END{ exit $EXITCODE; }
sub note(@){ print STDERR "$0: @_"; };
$SIG{'__WARN__'} = sub{ note @_; $EXITCODE = 1; };
$SIG{'__DIE__'} = sub{ warn @_; exit; };

(my $USAGE = <<__END_USAGE__) =~ s/^#[ ]?//gm;
#
# NAME
#    $0 - convert text to html <PRE>
#
# SYNOPSIS
#    $0 [-h] [infile...]
#
# DESCRIPTION
#    Reads <> and writes STDOUT, converting the input from
#    text to <PRE> HTML.  Links are added for any sequence
#    matching /http:\\S+/.
#
# $RCSID
__END_USAGE__

print $USAGE and exit if @ARGV and $ARGV[0] eq "-h";

my %htmlchars = (
   '&'=> '&amp;',
   '<'=> '&lt;',
   '>'=> '&gt;',
);

print "<PRE>\n";

while (defined (my $line = <>)) {
   $line =~ s![&<>]!$htmlchars{$&}!g;
   $line =~ s!(^|\W)(http:\S+)!$1<A HREF=$2>$2</A>!g;
   print $line;
};


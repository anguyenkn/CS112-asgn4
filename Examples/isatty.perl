#!/usr/bin/perl
# $Id: isatty.perl,v 1.1 2014-10-03 16:57:20-07 - - $

use POSIX qw (isatty);

sub printty ($$) {
   my ($handle, $bool) = @_;
   print "$handle is", ($bool ? "" : " not"), " a tty\n";
}

printty "STDIN", -t STDIN;
printty "STDOUT", -t STDOUT;
printty "STDERR", -t STDERR;

#!/usr/bin/perl
# $Id: yes.perl,v 1.1 2014-10-03 16:57:20-07 - - $
#
# NAME
#    yes - be repetitively affirmative
#
# SYNOPSIS
#    yes [expletive]
#
# DESCRIPTION
#    yes repeatedly outputs y, or if expletive is given, that is
#    output repeatedly.  Termination is by typing an interrupt
#    character or breaking the pipe.
#

my $expletive = "@ARGV" || "y";
print "$expletive\n" while 1;

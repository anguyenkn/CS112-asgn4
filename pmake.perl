#!/usr/bin/perl -w
use strict;
use warnings;

my $EXITCODE = 0;

#from getopts.perl
use Getopt::Std;
my %OPTS;
getopts("d", \%OPTS);

#from sigtoperl.output
my %strsignal = (
    1 => "Hangup",
    2 => "Interrupt",
    3 => "Quit",
    4 => "Illegal instruction",
    5 => "Trace/breakpoint trap",
    6 => "Aborted",
    7 => "Bus error",
    8 => "Floating point exception",
    9 => "Killed",
   11 => "Segmentation fault",
   13 => "Broken pipe",
   14 => "Alarm clock",
   15 => "Terminated",
   16 => "Stack fault",
   17 => "Child exited",
   18 => "Continued",
   19 => "Stopped (signal)",
   20 => "Stopped",
   21 => "Stopped (tty input)",
   22 => "Stopped (tty output)",
   24 => "CPU time limit exceeded",
   25 => "File size limit exceeded",
   26 => "Virtual timer expired",
   27 => "Profiling timer expired",
   28 => "Window changed",
   29 => "I/O possible",
   30 => "Power failure",
   31 => "Bad system call",
);

# init filename if theres no file then filename will be set to Makefile
my $filename = "Makefile";
$filename = $ARGV[0] if exists $ARGV[0];

# debugging information
print "filename: $filename\n" if $OPTS{'d'};


my %macrohash;

sub fetchhash {
    my $key = $_[0];
    #print "fetch hash $key\n";
    #print "its $macrohash{$key}\n" if exists $macrohash{$key};
    #return "hi";

    if (exists $macrohash{$key}) {
      return $macrohash{$key};
    } else {
      #Time ti do nexted macros!

      return "BOB"};
};

#fn for adding line to hashtable
sub inithash {
    my $line = $_[0];
    my ($key, $val) = split(/\s*=\s*/, $line);
    print "key: $key val: $val\n" if $OPTS{'d'};
    #print"val: $val\n";
    $val =~ s/\${(\S*)}/fetchhash($1)/eg;
    #print"next: $val\n";
    $macrohash{$key} = $val;
};

sub executecmd {
    my $line = $_[0];
    print "executing command: $line\n" if $OPTS{'d'};
    system("$line");
};

# from cat.perl
open my $infile, "<$filename" or warn "<$filename: $!\n" and next;
while (defined (my $line = <$infile>)) {
    chomp $line;
    # (m) is the match operator || capture groups
    # makefile syntax if # (comment) ignore
    next if $line =~ m/^\s*#/;
    # if macro = value -> put into hashtable (\S+) is the regex pattern to get macro val
    if ($line =~ m/\s*(\S+)\s*=\s+(.+)/) {
        print "macro detected: $line\n" if $OPTS{'d'};
        inithash $line;
        #my $key, $value = split '=' $line;
        #my ($key, $val) = split(/\s*=\s*/, $line);
        #print "key: $key val: $val\n";
    }
    # target ... : prereq
    elsif ($line =~ m/\s*(\S+)\s*:.*/) {
        #print "target prereq detected: $line\n" if $OPTS{'d'};
        my ($target, $deps) = split(/\s*:(\s.*)/, $line);
        print "target: $target deps: $deps\n";
    }
    # command (\t)
    elsif ($line =~ m/\t\s*(.+)/) {
        # command @
        if ($line =~ m/\t\s*@\s+(.+)/) {
            #executecmd $line;
            #print "command @ detected: $line\n" if $OPTS{'d'};
        }
        # command -
        elsif ($line =~ m/\t\s*-\s+(.t)/) {
            #executecmd $line;
            #print "command - detected: $line\n" if $OPTS{'d'};
        }
        #command -> stdout
        else {
            executecmd $line;
            print "command t detected: $line\n" if $OPTS{'d'};
        }
    }
}
close $infile;

#if decoding, print hashtable
if ($OPTS{'d'}) {
    print "\nHASTABLE\n\n";
    my ($k,$v) = (0,0);
    while ( ($k,$v) = each %macrohash ) {
        print "$k => $v\n";
    }
};

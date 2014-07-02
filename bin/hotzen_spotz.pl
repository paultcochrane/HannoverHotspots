#!/usr/bin/env perl
 
use warnings;
use strict;
 
use IO::Prompt;
 
print "Welcome to the Hannover Hotspot editor, version 0.1\n";
print "Use Ctrl+D to exit, type 'help' or '?' for help.\n";
 
my $prompt = "spotz_editor> ";
while( prompt $prompt ) {
    print $_, "\n";
}

# vim: expandtab shiftwidth=4 softtabstop=4

#!/usr/bin/env perl

use warnings;
use strict;

use IO::Prompt;

sub hotzen_spots {
    print "Welcome to the Hannover Hotspot editor, version 0.1\n";
    print "Use Ctrl+D to exit, type 'help' or '?' for help.\n";

    my $prompt = "spotz_editor> ";
    while( prompt $prompt ) {
        exit(0) if $_ eq "exit";

        print $_, "\n";
    }
}

hotzen_spots() unless caller();

# vim: expandtab shiftwidth=4 softtabstop=4

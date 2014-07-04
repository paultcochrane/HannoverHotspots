#!/usr/bin/env perl

=head1 NAME

hotzen_spotz - add, edit and delete HannoverHotspots entries

=head1 SYNOPSIS

    $ hotzen_spotz
    spotz_editor> add
    ...
    spotz_editor> edit
    ...
    spotz_editor> delete
    ...

=head1 DESCRIPTION

Starts an interactive shell with commands to add, edit and delete entries in
the list of WLAN hotspots in Hannover, Germany.

=head1 AUTHOR

Paul Cochrane <paul@liekut.de>

=head1 COPYRIGHT AND LICENSE

This program is free software; you may redistribute it and/or modify it
under the same terms as Perl itself.

=cut

use warnings;
use strict;
use autodie;
use Pod::Usage;

use IO::Prompt;

=over 4

=item hotzen_spotz()

Run the main command loop.

=cut

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

=back

=cut

# vim: expandtab shiftwidth=4 softtabstop=4

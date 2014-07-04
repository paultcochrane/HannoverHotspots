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

        add() if $_ eq "add";
        print $_, "\n";
    }
}

=item add()

Add a WLAN hotspot entry.

=cut

sub add {
    my $prompt = "Please enter the location's name: ";
    my $location_name = prompt("-p" => $prompt, -raw_input);

    $prompt = "Please enter location's type (cafe, bar, restaurant): ";
    my $location_type = prompt("-p" => $prompt, -raw_input);

    $prompt = "Please enter location's SSID: ";
    my $location_ssid = prompt("-p" => $prompt, -raw_input);

    $prompt = "Is WLAN free here? (yes/no): ";
    my $is_wlan_free = prompt("-p" => $prompt, -yes_no);

    $prompt = "Please enter the location's street address: ";
    my $location_street_address = prompt("-p" => $prompt, -raw_input);

    $prompt = "Please enter the location's URL: ";
    my $location_url = prompt("-p" => $prompt, -raw_input);

    $prompt = "Please enter the location's latitude (in degrees): ";
    my $location_latitude = prompt("-p" => $prompt, -num);

    $prompt = "Please enter the location's longitude (in degrees): ";
    my $location_longitude = prompt("-p" => $prompt, -num);

    $prompt = "Please enter notes about location's power points: ";
    my $power_points_notes = prompt("-p" => $prompt, -raw_input);

    $prompt = "Please enter notes about location's network speed: ";
    my $network_speed_notes = prompt("-p" => $prompt, -raw_input);

    $prompt = "Please enter extra notes about the location: ";
    my $extra_notes = prompt("-p" => $prompt, -raw_input);

    print "Entry information:\n";
    print "    Location name: ",       $location_name, "\n";
    print "    Location type: ",       $location_type, "\n";
    print "    Location SSID: ",       $location_ssid, "\n";
    print "    Free WLAN?: ",          $is_wlan_free, "\n";
    print "    Street address: ",      $location_street_address, "\n";
    print "    Location URL: ",        $location_url, "\n";
    print "    Location latitude: ",   $location_latitude, "\n";
    print "    Location longitude: ",  $location_longitude, "\n";
    print "    Power points notes: ",  $power_points_notes, "\n";
    print "    Network speed notes: ", $network_speed_notes, "\n";
    print "    Extra notes: ",         $extra_notes, "\n";
}

hotzen_spots() unless caller();

=back

=cut

# vim: expandtab shiftwidth=4 softtabstop=4

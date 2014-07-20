#!/usr/bin/env perl

use warnings;
use strict;

use Test::More tests => 13;

require_ok( "Hotspotz::Location" );

{
    my $location = Hotspotz::Location->new();
    is( $location->location_name, '', "location_name default value" );
    is( $location->location_type, '', "location_type default value" );
    is( $location->location_ssid, '', "location_ssid default value" );
    is( $location->is_wlan_free, '', "is_wlan_free default value" );
    is( $location->location_street_address, '', "location_street_address default value" );
    is( $location->location_url, '', "location_url default value" );
    is( $location->location_latitude, '', "location_latitude default value" );
    is( $location->location_longitude, '', "location_longitude default value" );
    is( $location->power_points_notes, '', "power_points_notes default value" );
    is( $location->network_speed_notes, '', "network_speed_notes default value" );
    is( $location->extra_notes, '', "extra_notes default value" );
    is( $location->last_update, '', "last_update default value" );
}

# vim: expandtab shiftwidth=4 softtabstop=4

#!/usr/bin/env perl

use warnings;
use strict;

use Test::More tests => 13;

require_ok( "Hotspotz::Location" );

{
    my $location = Hotspotz::Location->new();
    is( $location->name, '', "name default value" );
    is( $location->type, '', "type default value" );
    is( $location->ssid, '', "ssid default value" );
    is( $location->is_wlan_free, '', "is_wlan_free default value" );
    is( $location->street_address, '', "street_address default value" );
    is( $location->url, '', "url default value" );
    is( $location->latitude, '', "latitude default value" );
    is( $location->longitude, '', "longitude default value" );
    is( $location->power_points_notes, '', "power_points_notes default value" );
    is( $location->network_speed_notes, '', "network_speed_notes default value" );
    is( $location->extra_notes, '', "extra_notes default value" );
    is( $location->last_update, '', "last_update default value" );
}

# vim: expandtab shiftwidth=4 softtabstop=4

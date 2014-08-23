#!/usr/bin/env perl

use warnings;
use strict;

use Capture::Tiny 'capture_stdout';
use Test::More tests => 14;

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

{
    my $location = Hotspotz::Location->new();
    $location->name("Cafe with WLAN");
    $location->type("cafe");
    $location->ssid("CafeWLAN");
    $location->is_wlan_free("yes");
    $location->street_address("Unbekannter Weg 1");
    $location->url("http://cafewlan.de");
    $location->latitude(50.123456);
    $location->longitude(9.654321);
    $location->power_points_notes("Upstairs, in the corner");
    $location->network_speed_notes("Good; 500kbs download; 200kbs upload");
    $location->extra_notes("SSH blocked; HTTP(S) allowed");
    $location->last_update("2014-01-01");

    my $stdout = capture_stdout {
        $location->print();
    };

    my $expected =<<EOD;
Name:               Cafe with WLAN
Type:               cafe
SSID:               CafeWLAN
Free WLAN?:         yes
Street address:     Unbekannter Weg 1
URL:                http://cafewlan.de
Coordinates:        9.654321E, 50.123456N
Power points info:  Upstairs, in the corner
Network speed info: Good; 500kbs download; 200kbs upload
Extra info:         SSH blocked; HTTP(S) allowed
Last update:        2014-01-01
EOD
    is( $stdout, $expected );
}

# vim: expandtab shiftwidth=4 softtabstop=4

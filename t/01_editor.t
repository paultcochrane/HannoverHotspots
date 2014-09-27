#!/usr/bin/env perl

use warnings;
use strict;

use Test::More tests => 7;

require_ok( "Hotspotz::Editor" );

{
    my $editor = Hotspotz::Editor->new();
    eval {
        $editor->load_locations();
    };
    like( $@, qr/Missing filename argument./,
        "load_geojson() no arg error message" );
}

{
    my $editor = Hotspotz::Editor->new();
    eval {
        $editor->load_locations("nonexistent.json");
    };
    like( $@, qr/Input file 'nonexistent.json' not found./,
        "load_geojson() input file not found error message" );
}

{
    my $editor = Hotspotz::Editor->new();
    create_test_json_file();
    $editor->load_locations("test.json");

    is( $editor->locations_file, "test.json", "Locations file name" );

    unlink("test.json") if -f "test.json";
}

{
    my $editor = Hotspotz::Editor->new();
    create_test_json_file();
    $editor->load_locations("test.json");

    my @locations = @{$editor->locations()};
    is( @locations, 2, "Number of locations loaded" );

    unlink("test.json") if -f "test.json";
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

    my $editor = Hotspotz::Editor->new();
    my @locations;
    push @locations, $location;
    $editor->locations_file("test.json");
    $editor->locations(\@locations);
    $editor->save_locations();

    $editor->load_locations("test.json");
    @locations = @{$editor->locations()};

    is( @locations, 1, "Number of locations loaded" );

    unlink("test.json") if -f "test.json";
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

    my $editor = Hotspotz::Editor->new();
    create_test_json_file();
    $editor->load_locations("test.json");
    my @locations = @{$editor->locations()};
    push @locations, $location;
    $editor->locations(\@locations);
    $editor->save_locations();

    $editor->load_locations("test.json");
    @locations = @{$editor->locations()};

    is( @locations, 3, "Number of locations loaded" );

    unlink("test.json") if -f "test.json";
}

sub create_test_json_file {
    open my $fh, ">", "test.json" or die "$!";
    print $fh <<EOF;
{
    "type": "FeatureCollection",
    "features": [
        {
            "type": "Feature",
            "geometry": {
                "type": "Point",
                "coordinates": [
                    9.714223, 52.367205
                    ]
            },
            "properties": {
                "marker-symbol": "bar",
                "marker-color": "00ff00",
                "title" : "Lindens Centrum",
                "name" : "Lindens Centrum",
		"type" : "Bar",
                "address" : "Lindener Marktplatz 3",
                "ssid" : "LindenerCentrum",
                "password" : "Ask the friendly staff",
                "wlan_is_free" : "yes",
                "speed" : "good",
                "url"  : "http://www.lindens-centrum.de/",
                "power_points" : "",
                "last_update" : "2014-05-30"
            }
        },
        {
            "type": "Feature",
            "geometry": {
                "type": "Point",
                "coordinates": [
                    9.725181, 52.384377
                    ]
            },
            "properties" : {
                "marker-symbol": "cafe",
                "marker-color": "00ff00",
                "name" : "Cafe Spandau",
		"type" : "Cafe",
                "address" : "Engelbosteler Damm 30",
                "ssid" : "SPANDAU_G",
                "password" : "Ask the friendly staff",
                "wlan_is_free" : "yes",
                "speed" : "good",
                "url" : "http://www.spandau-projekt.de/",
                "power_points" : "",
                "last_update" : ""
            }
        }
    ]
}
EOF
    close $fh;
}

# vim: expandtab shiftwidth=4 softtabstop=4

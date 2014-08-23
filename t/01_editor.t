#!/usr/bin/env perl

use warnings;
use strict;

use Test::More tests => 4;

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

    my @locations = @{$editor->locations()};
    is( @locations, 2, "Number of locations loaded" );
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
                "wlan" : "yes",
                "free" : "yes",
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
                "wlan" : "yes",
                "free" : "yes",
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

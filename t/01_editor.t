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
    $editor->load_geojson("test.json");

    my @locations = @{$editor->locations()};
    is( @locations, 2, "Number of locations loaded" );
}

# vim: expandtab shiftwidth=4 softtabstop=4

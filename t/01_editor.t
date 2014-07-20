#!/usr/bin/env perl

use warnings;
use strict;

use Test::More tests => 3;

require_ok( "Hotspotz::Editor" );

{
    my $editor = Hotspotz::Editor->new();
    eval {
        $editor->load_geojson();
    };
    like( $@, qr/Missing filename argument./,
        "load_geojson() no arg error message" );
}

{
    my $editor = Hotspotz::Editor->new();
    eval {
        $editor->load_geojson("nonexistent.json");
    };
    like( $@, qr/Input file 'nonexistent.json' not found./,
        "load_geojson() input file not found error message" );
}

# vim: expandtab shiftwidth=4 softtabstop=4

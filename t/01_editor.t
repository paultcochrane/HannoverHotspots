#!/usr/bin/env perl

use warnings;
use strict;

use Test::More tests => 2;

require_ok( "Hotspotz::Editor" );

{
    my $editor = Hotspotz::Editor->new();
    eval {
        $editor->load_geojson();
    };
    like( $@, qr/Missing filename argument./,
        "load_geojson() no arg error message" );
}

# vim: expandtab shiftwidth=4 softtabstop=4

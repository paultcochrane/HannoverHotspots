#!/usr/bin/env perl

use warnings;
use strict;

use Test::More tests => 1;

require_ok( "Hotspotz::Editor" );

{
    my $editor = Hotspotz::Editor->new();
    $editor->load_geojson();
}

# vim: expandtab shiftwidth=4 softtabstop=4

package Hotspotz::Location;

use Moose;

my @attrs = qw(
    name
    type
    ssid
    is_wlan_free
    street_address
    url
    latitude
    longitude
    power_points_notes
    network_speed_notes
    extra_notes
    last_update
    );
has \@attrs => (
    is => 'rw',
    default => '',
);

1;

# vim: expandtab shiftwidth=4 softtabstop=4

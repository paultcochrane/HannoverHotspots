package Hotspotz::Location;

use Moose;

my @attrs = qw(
    location_name
    location_type
    location_ssid
    is_wlan_free
    location_street_address
    location_url
    location_latitude
    location_longitude
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

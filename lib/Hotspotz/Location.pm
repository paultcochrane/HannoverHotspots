package Hotspotz::Location;

use Moose;
use autodie;

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

=item print

Display a location's information

=cut

sub print {
    my $self = shift;

    print "Name: ",               $self->name, "\n";
    print "Type: ",               $self->type, "\n";
    print "SSID: ",               $self->ssid, "\n";
    print "Free WLAN?: ",         $self->is_wlan_free, "\n";
    print "Street address: ",     $self->street_address, "\n";
    print "URL: ",                $self->url, "\n";
    print "Coordinates: ",        $self->longitude, "E, ",
                                  $self->latitude, "N", "\n";
    print "Power points info: ",  $self->power_points_notes, "\n";
    print "Network speed info: ", $self->network_speed_notes, "\n";
    print "Extra info: ",         $self->extra_notes, "\n";
    print "Last update: ",        $self->last_update, "\n";
}

1;

# vim: expandtab shiftwidth=4 softtabstop=4

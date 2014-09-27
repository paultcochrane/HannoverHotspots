package Hotspotz::Editor;

use Moose;
use Term::ReadLine::Perl5;
use JSON;
use Carp;
use autodie;

use Hotspotz::Location;

has 'command_prompt' => (
    is => 'ro',
    default => "spotz_editor> ",
);

has 'version' => (
    is => 'ro',
    default => 0.1,
);

has 'locations' => (
    is => 'rw',
);

=item print_welcome()

Print the program's welcome text

=cut

sub print_welcome {
    my $self = shift;

    print "Welcome to the Hannover Hotspot editor, version ",
        $self->version, "\n",
        "Use Ctrl+D to exit, type 'help' or '?' for help.\n";
}

=item command_loop

Start the command loop

=cut

sub command_loop {
    my $self = shift;

    $self->load_locations("hannover_hotspots.json");

    my $term = new Term::ReadLine::Perl5 'Hannover Hotspots Editor';
    while( defined ($_ = $term->readline($self->command_prompt)) ) {
        if ($_ =~ /exit|x|quit|q/) {
            $self->exit_program();
        }
        elsif ($_ eq "add") {
            $self->add_entry($term);
        }
        elsif ($_ eq "list") {
            $self->list_entries();
        }
        elsif ($_ =~ /^show/) {
            $self->show_entry($_);
        }
        elsif ($_ =~ /^load (.*)$/) {
            $self->load_locations($1);
        }
        elsif ($_ eq "help" or $_ eq "?") {
            $self->print_help();
        }
        else {
            print "Unknown command: $_\n";
        }
    }
}

=item exit_program()

Exit the hotspots editor program.

=cut

sub exit_program {
    exit(0);
}

=item add_entry()

Add a WLAN hotspot entry.

=cut

sub add_entry {
    my ($self, $term) = @_;

    my $location = Hotspotz::Location->new();

    my $prompt = "Please enter the location's name: ";
    $location->name($term->readline($prompt));

    $prompt = "Please enter location's type (cafe, bar, restaurant): ";
    $location->type($term->readline($prompt));

    $prompt = "Please enter location's SSID: ";
    $location->ssid($term->readline($prompt));

    $prompt = "Is WLAN free here? (yes/no): ";
    $location->is_wlan_free($term->readline($prompt));

    $prompt = "Please enter the location's street address: ";
    $location->street_address($term->readline($prompt));

    $prompt = "Please enter the location's URL: ";
    $location->url($term->readline($prompt));

    $prompt = "Please enter the location's latitude (in degrees): ";
    $location->latitude($term->readline($prompt));

    $prompt = "Please enter the location's longitude (in degrees): ";
    $location->longitude($term->readline($prompt));

    $prompt = "Please enter notes about location's power points: ";
    $location->power_points_notes($term->readline($prompt));

    $prompt = "Please enter notes about location's network speed: ";
    $location->network_speed_notes($term->readline($prompt));

    $prompt = "Please enter extra notes about the location: ";
    $location->extra_notes($term->readline($prompt));

    print "Entry information:\n";
    $location->print();

    push $self->locations, $location;
}

=item list_entries()

List all available WLAN hotspot entries.

=cut

sub list_entries {
    my $self = shift;

    my $index = 1;
    for my $location ( @{$self->locations} ) {
        print "[", $index, "] ", $location->name, "\n";
        $index++;
    }
}

=item show_entry(entry_id)

Show all information for the given entry id

=cut

sub show_entry {
    my ($self, $command_line) = @_;
    my ($command, $location_index) = split '\s+', $command_line;

    my @locations = @{$self->locations};

    if (not defined $locations[$location_index-1]) {
        print "Entry at index $location_index not found\n";
        return;
    }
    my $location = $locations[$location_index-1];

    $location->print();
}

=item print_help()

Print a list of available commands.

=cut

sub print_help {
    print "Available commands:\n";
    print "    add:                add a new hotspot entry\n";
    print "    list:               list available hotspot entries\n";
    print "    show <entry_index>: display entry's details\n";
    print "    help:               display this help\n";
}

=item load_locations(filename)

Load location information from the given filename

=cut

sub load_locations {
    my ($self, $file) = @_;

    croak "Missing filename argument." unless $file;
    croak "Input file '$file' not found." unless -e $file;

    my $json = JSON->new();
    $json->utf8();

    open my $hotspots_fh, "<", $file;
    my @hotspots_lines = <$hotspots_fh>;
    close $hotspots_fh;

    my $hotspots_json = join "", @hotspots_lines;
    my $geojson = $json->decode($hotspots_json);
    my @features = @{$geojson->{'features'}};
    my @locations;
    for my $feature ( @features ) {
        my $location = Hotspotz::Location->new();
        my $props = $feature->{'properties'};
        $location->name($props->{'name'});
        $location->type(ucfirst $props->{'marker-symbol'});
        $location->ssid($props->{'ssid'});
        $location->is_wlan_free($props->{'wlan_is_free'});
        $location->street_address($props->{'address'});
        $location->url($props->{'url'});
        $location->power_points_notes($props->{'power_points'});
        $location->network_speed_notes($props->{'speed'});
        $props->{'notes'}
            ? $location->extra_notes($props->{'notes'})
            : $location->extra_notes('');
        $location->last_update($props->{'last_update'});

        my @geometry = @{$feature->{'geometry'}->{'coordinates'}};
        $location->latitude($geometry[1]);
        $location->longitude($geometry[0]);

        push @locations, $location;
    }

    $self->locations(\@locations);
}

=item save_locations(filename)

Save the current locations list to file

=cut

sub save_locations {
    my ($self, $file) = @_;

    my $json = JSON->new();
    $json->utf8();

    my @locations = @{$self->locations()};

    my @features;
    for my $location ( @locations ) {
        my %point;
        $point{"type"} = "Point";
        $point{"coordinates"} = [$location->latitude(), $location->longitude()];

        my %properties;
        $properties{"marker-symbol"} = lc $location->type();
        $properties{"marker-color"} = "00ff00";
        $properties{"title"} = $location->name();
        $properties{"name"} = $location->name();
        $properties{"address"} = $location->street_address();
        $properties{"ssid"} = $location->ssid();
        $properties{"password"} = "Ask the friendly staff";  # this needs to be handled
        $properties{"wlan_is_free"} = $location->is_wlan_free();
        $properties{"speed"} = $location->network_speed_notes();
        $properties{"url"} = $location->url();
        $properties{"power_points"} = $location->power_points_notes();
        $properties{"last_update"} = $location->last_update();

        my %feature;
        $feature{"type"} = "Feature";
        $feature{"geometry"} = \%point;
        $feature{"properties"} = \%properties;

        push @features, \%feature;
    }

    my %feature_collection;
    $feature_collection{"type"} = "FeatureCollection";
    $feature_collection{"features"} = \@features;

    my $json_text = $json->pretty->encode(\%feature_collection);

    open my $hotspots_fh, ">", $file;
    print $hotspots_fh $json_text;
    close $hotspots_fh;
}

1;

# vim: expandtab shiftwidth=4 softtabstop=4

package Hotspotz::Editor;

use Moose;
use IO::Prompt;
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

    while( prompt $self->command_prompt ) {
        if ($_ eq "exit") {
            $self->exit_program();
        }
        elsif ($_ eq "add") {
            $self->add_entry();
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
    my $location = Hotspotz::Location->new();

    my $prompt = "Please enter the location's name: ";
    $location->name(prompt("-p" => $prompt, -raw_input));

    $prompt = "Please enter location's type (cafe, bar, restaurant): ";
    $location->type(prompt("-p" => $prompt, -raw_input));

    $prompt = "Please enter location's SSID: ";
    $location->ssid(prompt("-p" => $prompt, -raw_input));

    $prompt = "Is WLAN free here? (yes/no): ";
    $location->is_wlan_free(prompt("-p" => $prompt, -yes_no));

    $prompt = "Please enter the location's street address: ";
    $location->street_address(prompt("-p" => $prompt, -raw_input));

    $prompt = "Please enter the location's URL: ";
    $location->url(prompt("-p" => $prompt, -raw_input));

    $prompt = "Please enter the location's latitude (in degrees): ";
    $location->latitude(prompt("-p" => $prompt, -num));

    $prompt = "Please enter the location's longitude (in degrees): ";
    $location->longitude(prompt("-p" => $prompt, -num));

    $prompt = "Please enter notes about location's power points: ";
    $location->power_points_notes(prompt("-p" => $prompt, -raw_input));

    $prompt = "Please enter notes about location's network speed: ";
    $location->network_speed_notes(prompt("-p" => $prompt, -raw_input));

    $prompt = "Please enter extra notes about the location: ";
    $location->extra_notes(prompt("-p" => $prompt, -raw_input));

    print "Entry information:\n";
    print "    Location name: ",       $location->name, "\n";
    print "    Location type: ",       $location->type, "\n";
    print "    Location SSID: ",       $location->ssid, "\n";
    print "    Free WLAN?: ",          $location->is_wlan_free, "\n";
    print "    Street address: ",      $location->street_address, "\n";
    print "    Location URL: ",        $location->url, "\n";
    print "    Location latitude: ",   $location->latitude, "\n";
    print "    Location longitude: ",  $location->longitude, "\n";
    print "    Power points notes: ",  $location->power_points_notes, "\n";
    print "    Network speed notes: ", $location->network_speed_notes, "\n";
    print "    Extra notes: ",         $location->extra_notes, "\n";
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
    my $location = $locations[$location_index-1];

    $location->print();
}

=item print_help()

Print a list of available commands.

=cut

sub print_help {
    print "Available commands:\n";
    print "    add:  add a new hotspot entry\n";
    print "    list: list available hotspot entries\n";
    print "    help: display this help\n";
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
        $location->name($feature->{'properties'}->{'name'});

        push @locations, $location;
    }

    $self->locations(\@locations);
}

1;

# vim: expandtab shiftwidth=4 softtabstop=4

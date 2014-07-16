package HotspotsEditor;

use Moose;
use IO::Prompt;
use JSON;

has 'command_prompt' => (
    is => 'ro',
    default => "spotz_editor> ",
);

has 'version' => (
    is => 'ro',
    default => 0.1,
);

my @attrs = qw(location_name location_type);
has \@attrs => (
    is => 'rw',
    default => '',
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
        elsif ($_ eq "help") {
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
    my $self = shift;

    my $prompt = "Please enter the location's name: ";
    $self->location_name(prompt("-p" => $prompt, -raw_input));

    $prompt = "Please enter location's type (cafe, bar, restaurant): ";
    $self->location_type(prompt("-p" => $prompt, -raw_input));

    $prompt = "Please enter location's SSID: ";
    my $location_ssid = prompt("-p" => $prompt, -raw_input);

    $prompt = "Is WLAN free here? (yes/no): ";
    my $is_wlan_free = prompt("-p" => $prompt, -yes_no);

    $prompt = "Please enter the location's street address: ";
    my $location_street_address = prompt("-p" => $prompt, -raw_input);

    $prompt = "Please enter the location's URL: ";
    my $location_url = prompt("-p" => $prompt, -raw_input);

    $prompt = "Please enter the location's latitude (in degrees): ";
    my $location_latitude = prompt("-p" => $prompt, -num);

    $prompt = "Please enter the location's longitude (in degrees): ";
    my $location_longitude = prompt("-p" => $prompt, -num);

    $prompt = "Please enter notes about location's power points: ";
    my $power_points_notes = prompt("-p" => $prompt, -raw_input);

    $prompt = "Please enter notes about location's network speed: ";
    my $network_speed_notes = prompt("-p" => $prompt, -raw_input);

    $prompt = "Please enter extra notes about the location: ";
    my $extra_notes = prompt("-p" => $prompt, -raw_input);

    print "Entry information:\n";
    print "    Location name: ",       $self->location_name, "\n";
    print "    Location type: ",       $self->location_type, "\n";
    print "    Location SSID: ",       $location_ssid, "\n";
    print "    Free WLAN?: ",          $is_wlan_free, "\n";
    print "    Street address: ",      $location_street_address, "\n";
    print "    Location URL: ",        $location_url, "\n";
    print "    Location latitude: ",   $location_latitude, "\n";
    print "    Location longitude: ",  $location_longitude, "\n";
    print "    Power points notes: ",  $power_points_notes, "\n";
    print "    Network speed notes: ", $network_speed_notes, "\n";
    print "    Extra notes: ",         $extra_notes, "\n";
}

=item list_entries()

List all available WLAN hotspot entries.

=cut

sub list_entries {
    my $json = JSON->new();
    $json->utf8();

    open my $hotspots_fh, "<", "hannover_hotspots.json";
    my @hotspots_lines = <$hotspots_fh>;
    close $hotspots_fh;

    my $hotspots_json = join "", @hotspots_lines;
    my $geojson = $json->decode($hotspots_json);
    my @features = @{$geojson->{'features'}};
    my $index = 1;
    for my $location ( @features ) {
        print "[", $index, "] ", $location->{'properties'}->{'name'}, "\n";
        $index++;
    }
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

1;

# vim: expandtab shiftwidth=4 softtabstop=4

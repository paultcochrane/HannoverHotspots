package HotspotsEditor;

use Moose;
use IO::Prompt;
use JSON;

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
    my $prompt = "Please enter the location's name: ";
    my $location_name = prompt("-p" => $prompt, -raw_input);

    $prompt = "Please enter location's type (cafe, bar, restaurant): ";
    my $location_type = prompt("-p" => $prompt, -raw_input);

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
    print "    Location name: ",       $location_name, "\n";
    print "    Location type: ",       $location_type, "\n";
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

1;

# vim: expandtab shiftwidth=4 softtabstop=4

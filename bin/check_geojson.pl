#!/usr/bin/env perl

use warnings;
use strict;
use autodie;

use HTTP::Request::Common;
use LWP::UserAgent;
use JSON;

=head1 NAME

check_geojson.pl - check Hannover Hotspots JSON file for correctness

=head1 DESCRIPTION

A script which connects to the C<http://geojsonlint.com> GeoJSON validation
site and checks the C<hannover_hotspots.json> file for correctness.

=head1 SYNOPSIS

    $ check_geojson.pl

=head1 AUTHOR

Paul Cochrane <paul@leikut.de>

=cut

sub load_json {
    open my $json_fh, "<", "hannover_hotspots.json";
    my @lines = <$json_fh>;
    close $json_fh;

    return join("", @lines);
}

sub validate_json {
    my $hotspots_json = shift;
    my $validate_endpoint = "http://geojsonlint.com/validate";

    my $ua = LWP::UserAgent->new;
    my $request = $ua->request(POST $validate_endpoint, Content => $hotspots_json);
    my $validation_json = $request->content();

    my $validation = from_json($validation_json, {utf8 => 1});

    return $validation->{"status"};
}

sub print_validation_info {
    my $validation_status = shift;

    if ($validation_status eq "ok") {
	print "Valid geoJSON.  Now you can submit a pull request!\n";
	exit(0);
    }
    else {
	print "Invalid geoJSON.  Please correct and check again.\n";
	exit(255);
    }
}

sub check_geojson {
    my $hotspots_json = load_json();
    my $validation_result = validate_json($hotspots_json);
    print_validation_info($validation_result);
}

check_geojson() unless caller();

# vim: expandtab shiftwidth=4 softtabstop=4

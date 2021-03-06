use warnings;
use strict;

use Test::More;
use Test::BDD::Cucumber::StepFile;
use Method::Signatures;

our $timeout = 2;

When qr/^I add a new entry$/, func($context) {
    my $spotz = S->{'spotz'};
    my @add_entry_overview = [];
    $spotz->send("add\n");

    my $prompt = "Please enter the location's name:";
    $spotz->expect($timeout, $prompt);

    my $answer = "Cafe with WLAN";
    $spotz->send("$answer\n");
    push @add_entry_overview, $answer;

    $prompt = "Please enter location's type (cafe, bar, restaurant):";
    $spotz->expect($timeout, $prompt);

    $answer = "cafe";
    $spotz->send("$answer\n");
    push @add_entry_overview, $answer;

    $prompt = "Please enter location's SSID:";
    $spotz->expect($timeout, $prompt);

    $answer = "CafeWLAN";
    $spotz->send("$answer\n");
    push @add_entry_overview, $answer;

    $prompt = "Is WLAN free here? (yes/no):";
    $spotz->expect($timeout, $prompt);

    $answer = "yes";
    $spotz->send("$answer\n");
    push @add_entry_overview, $answer;

    $prompt = "Please enter the location's street address:";
    $spotz->expect($timeout, $prompt);

    $answer = "Unbekannter Weg 1";
    $spotz->send("$answer\n");
    push @add_entry_overview, $answer;

    $prompt = "Please enter the location's URL:";
    $spotz->expect($timeout, $prompt);

    $answer = "http://cafewlan.de";
    $spotz->send("$answer\n");
    push @add_entry_overview, $answer;

    $prompt = "Please enter the location's latitude (in degrees):";
    $spotz->expect($timeout, $prompt);

    $answer = 50.123456;
    $spotz->send("$answer\n");
    push @add_entry_overview, $answer;

    $prompt = "Please enter the location's longitude (in degrees):";
    $spotz->expect($timeout, $prompt);

    $answer = 9.654321;
    $spotz->send("$answer\n");
    push @add_entry_overview, $answer;

    $prompt = "Please enter notes about location's power points:";
    $spotz->expect($timeout, $prompt);

    $answer = "Upstairs, in the corner";
    $spotz->send("$answer\n");
    push @add_entry_overview, $answer;

    $prompt = "Please enter notes about location's network speed:";
    $spotz->expect($timeout, $prompt);

    $answer = "Good; 500kbs download; 200kbs upload";
    $spotz->send("$answer\n");
    push @add_entry_overview, $answer;

    $prompt = "Please enter extra notes about the location:";
    $spotz->expect($timeout, $prompt);

    $answer = "SSH blocked; HTTP(S) allowed";
    $spotz->send("$answer\n");
    push @add_entry_overview, $answer;

    my $message = "Entry information:";
    my $index = $spotz->expect($timeout, $message);
    is($index, 1, "Entry information overview");
};

# vim: expandtab shiftwidth=4 softtabstop=4

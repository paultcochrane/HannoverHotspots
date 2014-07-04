use warnings;
use strict;

use Test::More;
use Test::BDD::Cucumber::StepFile;
use Method::Signatures;

use Expect;

When qr/I enter "add"/, func($context) {
    my $spotz = $context->stash->{'scenario'}->{'object'};
    $spotz->send("add\n");
    is($spotz->match_number(), 1, "Add command entry");
};

Then qr/I should be prompted for the location's name/, func($context) {
    my $spotz = $context->stash->{'scenario'}->{'object'};
    my $prompt = "Please enter the location's name: ";
    my $index = $spotz->expect(1, $prompt);
    is($index, 1, "Location name prompt");
};

When qr/I enter the location's name/, func($context) {
    my $spotz = $context->stash->{'scenario'}->{'object'};
    $spotz->send("Cafe with WLAN\n");
    is($spotz->match_number(), 1, "Location name entry");
};

Then qr/I should be prompted for the type of location/, func($context) {
    my $spotz = $context->stash->{'scenario'}->{'object'};
    my $prompt = "Please enter location's type (cafe, bar, restaurant): ";
    my $index = $spotz->expect(1, $prompt);
    is($index, 1, "Location type prompt");
};

When qr/I enter the location's type/, func($context) {
    my $spotz = $context->stash->{'scenario'}->{'object'};
    $spotz->send("cafe\n");
    is($spotz->match_number(), 1, "Location type entry");
};

Then qr/I should be prompted for the location's SSID/, func($context) {
    my $spotz = $context->stash->{'scenario'}->{'object'};
    my $prompt = "Please enter location's SSID: ";
    my $index = $spotz->expect(1, $prompt);
    is($index, 1, "Location SSID prompt");
};

When qr/I enter the location's SSID/, func($context) {
    my $spotz = $context->stash->{'scenario'}->{'object'};
    $spotz->send("CafeWLAN\n");
    is($spotz->match_number(), 1, "Location SSID entry");
};

# vim: expandtab shiftwidth=4 softtabstop=4

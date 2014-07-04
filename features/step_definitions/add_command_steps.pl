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
    $spotz->expect($prompt);
    my $index = $spotz->expect(1, $prompt);
    is($index, 1, "Location name prompt");
};

When qr/I enter the location's name/, func($context) {
    my $spotz = $context->stash->{'scenario'}->{'object'};
    $spotz->send("Cafe with WLAN\n");
    is($spotz->match_number(), 1, "Location name entry");
};

# vim: expandtab shiftwidth=4 softtabstop=4

use warnings;
use strict;

use Test::More;
use Test::BDD::Cucumber::StepFile;
use Method::Signatures;

use Expect;

# No entries to show
Given qr/^there are no entries$/, func($context) {
    my $spotz = $context->stash->{'scenario'}->{'object'};
    ok(0);
};

When qr/^I enter \"show\"$/, func($context) {
    my $spotz = $context->stash->{'scenario'}->{'object'};
    $spotz->send("show\n");
    is($spotz->match_number(), 1, "Show command entry");
};

Then qr/^I should see a warning about no entries$/, func($context) {
    my $spotz = $context->stash->{'scenario'}->{'object'};
    ok(0);
};

# entries to show
Given qr/^I have explicitly loaded a location file$/, func($context) {
    my $spotz = $context->stash->{'scenario'}->{'object'};
    $spotz->send("load test.json\n");
    is($spotz->match_number(), 1, "Load command entry");
};

When qr/^I enter \"show\" for entry \[2\]$/, func($context) {
    my $spotz = $context->stash->{'scenario'}->{'object'};
    $spotz->send("show 2\n");
};

Then qr/^I should see all information for the given entry$/, func($context) {
    my $spotz = $context->stash->{'scenario'}->{'object'};

    my $index = $spotz->expect(1, "Name: Cafe Spandau");
    is($index, 1, "Show command output: name");

    $index = $spotz->expect(1, "Type: Cafe");
    is($index, 1, "Show command output: type");

    $index = $spotz->expect(1, "SSID: SPANDAU_G");
    is($index, 1, "Show command output: ssid");

    $index = $spotz->expect(1, "Free WLAN?: yes");
    is($index, 1, "Show command output: free wlan?");

    $index = $spotz->expect(1, "Street address: Engelbosteler Damm 30");
    is($index, 1, "Show command output: street address");

    $index = $spotz->expect(1, "URL: http://www.spandau-projekt.de/");
    is($index, 1, "Show command output: url");

    $index = $spotz->expect(1, "Coordinates: 9.725181E, 52.384377N");
    is($index, 1, "Show command output: coordinates");

    $index = $spotz->expect(1, "Power points info: ");
    is($index, 1, "Show command output: power points");

    $index = $spotz->expect(1, "Network speed info: good");
    is($index, 1, "Show command output: network speed");

    $index = $spotz->expect(1, "Extra info: ");
    is($index, 1, "Show command output: extra info");

    $index = $spotz->expect(1, "Last update: ");
    is($index, 1, "Show command output: last update");
};

# vim: expandtab shiftwidth=4 softtabstop=4

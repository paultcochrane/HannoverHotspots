use warnings;
use strict;

use Test::More;
use Test::BDD::Cucumber::StepFile;
use Method::Signatures;

use Expect;

When qr/^I enter \"load\" with an existing filename$/, func($context) {
    my $spotz = $context->stash->{'scenario'}->{'object'};
    $spotz->send("load test.json\n");
    is($spotz->match_number(), 1, "Load command entry");
};

Then qr/^I should see the entries in the loaded file$/, func($context) {
    my $spotz = $context->stash->{'scenario'}->{'object'};
    my $index = $spotz->expect(1, "Lindens Centrum");
    is($index, 1, "Display entry from explicitly loaded file");
    $index = $spotz->expect(1, "Cafe Spandau");
    is($index, 1, "Display entry from explicitly loaded file");
};

# vim: expandtab shiftwidth=4 softtabstop=4

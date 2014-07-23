use warnings;
use strict;

use Test::More;
use Test::BDD::Cucumber::StepFile;
use Method::Signatures;

use Expect;

When qr/^I enter an unknown command$/, func($context) {
    my $spotz = $context->stash->{'scenario'}->{'object'};
    $spotz->send("moo\n");
    is($spotz->match_number(), 1, "Enter unknown command");
};

Then qr/^I should be told that the command is unknown$/, func($context) {
    my $spotz = $context->stash->{'scenario'}->{'object'};
    my $index = $spotz->expect(1, "Unknown command: moo");
    is($index, 1, "Unknown command response");
};

# vim: expandtab shiftwidth=4 softtabstop=4

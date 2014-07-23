use warnings;
use strict;

use Test::More;
use Test::BDD::Cucumber::StepFile;
use Method::Signatures;

use Expect;

When qr/^I enter \"help\"$/, func($context) {
    my $spotz = $context->stash->{'scenario'}->{'object'};
    $spotz->send("help\n");
    is($spotz->match_number(), 1, "Help command entry");
};

When qr/^I enter \"?\"$/, func($context) {
    my $spotz = $context->stash->{'scenario'}->{'object'};
    $spotz->send("?\n");
    is($spotz->match_number(), 1, "Help command entry");
};

Then qr/^I should see a list of available commands$/, func($context) {
    my $spotz = $context->stash->{'scenario'}->{'object'};
    my $index = $spotz->expect(1, "Available commands:");
    is($index, 1, "Help command output");
    $index = $spotz->expect(1, "add");
    is($index, 1, "Help command output (add)");
    $index = $spotz->expect(1, "list");
    is($index, 1, "Help command output (list)");
};

# vim: expandtab shiftwidth=4 softtabstop=4

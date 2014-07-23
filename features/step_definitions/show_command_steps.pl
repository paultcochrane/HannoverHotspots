use warnings;
use strict;

use Test::More;
use Test::BDD::Cucumber::StepFile;
use Method::Signatures;

use Expect;

# No entries to show
Given qr/there are no entries/, func($context) {
    my $spotz = $context->stash->{'scenario'}->{'object'};
    ok(0);
};

When qr/^I enter "show"$/, func($context) {
    my $spotz = $context->stash->{'scenario'}->{'object'};
    $spotz->send("show\n");
    is($spotz->match_number(), 1, "Show command entry");
};

Then qr/I should see a warning about no entries/, func($context) {
    my $spotz = $context->stash->{'scenario'}->{'object'};
    ok(0);
};

# entries to show
Given qr/a non-empty list of entries/, func($context) {
    my $spotz = $context->stash->{'scenario'}->{'object'};
    ok(0);
};

When qr/^I enter "show" for entry \[2\]$/, func($context) {
    my $spotz = $context->stash->{'scenario'}->{'object'};
    $spotz->send("show 2\n");
};

Then qr/I should see all information for the given entry/, func($context) {
    my $spotz = $context->stash->{'scenario'}->{'object'};
    ok(0);
};

# vim: expandtab shiftwidth=4 softtabstop=4

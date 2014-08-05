use warnings;
use strict;

use Test::More;
use Test::BDD::Cucumber::StepFile;
use Method::Signatures;

use Expect;

When qr/^I enter \"list\"$/, func($context) {
    my $spotz = S->{'object'};
    $spotz->send("list\n");
    is($spotz->match_number(), 1, "List command entry");
};

Then qr/^I should see a list of available entries$/, func($context) {
    my $spotz = S->{'object'};
    my $index = $spotz->expect(1, "Lindens Centrum");
    is($index, 1, "List command output");
};

# vim: expandtab shiftwidth=4 softtabstop=4

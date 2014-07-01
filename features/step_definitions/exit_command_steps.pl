use warnings;
use strict;

use Test::More;
use Test::BDD::Cucumber::StepFile;
use Method::Signatures;

use Expect;

When qr/I enter "exit"/, func($context) {
    my $spotz = $context->stash->{'scenario'}->{'object'};
    $spotz->send("exit\n");
};

Then qr/the program should exit cleanly/, func($context) {
    my $spotz = $context->stash->{'scenario'}->{'object'};
    $spotz->soft_close();
    is($spotz->exitstatus(), 0, "hotzen_spotz appears to be still running");
};

# vim: expandtab shiftwidth=4 softtabstop=4

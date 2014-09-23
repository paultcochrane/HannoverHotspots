use warnings;
use strict;

use Test::More;
use Test::BDD::Cucumber::StepFile;
use Method::Signatures;

When qr/^I enter \"(exit|x|quit|q)\"$/, func($context) {
    my $exit_command = $1;
    my $spotz = S->{'spotz'};
    $spotz->send("$exit_command\n");
};

Then qr/^the program should exit cleanly$/, func($context) {
    my $spotz = S->{'spotz'};
    $spotz->soft_close();
    is($spotz->exitstatus(), 0, "hotzen_spotz appears to be still running");
};

# vim: expandtab shiftwidth=4 softtabstop=4

use warnings;
use strict;

use Test::More;
use Test::BDD::Cucumber::StepFile;
use Method::Signatures;

use Expect;

our $timeout = 2;

Given qr/^the program hotzen_spotz is run$/, func($context) {
    my $command = "bin/hotzen_spotz";
    my $spotz = Expect->spawn($command)
	or die "Cannot spawn $command: $!\n";
    ok(defined($spotz->pid()), "No PID; command appears not to be running");
    S->{'spotz'} = $spotz;
};

Then qr/^I should see the welcome screen$/, func($context) {
    my $spotz = S->{'spotz'};
    my $message = "Welcome to the Hannover Hotspot editor, version 0.1";
    my $index = $spotz->expect($timeout, $message);
    is($index, 1, "Welcome message line 1");

    $message = "Use Ctrl+D to exit, type 'help' or '?' for help.";
    $index = $spotz->expect($timeout, $message);
    is($index, 1, "Welcome message line 2");
};

Given qr/^I have seen the welcome screen$/, func($context) {
    my $spotz = S->{'spotz'};
    my $message = "Welcome to the Hannover Hotspot editor, version 0.1";
    my $index = $spotz->expect($timeout, $message);
    is($index, 1, "Welcome message line 1");

    $message = "Use Ctrl+D to exit, type 'help' or '?' for help.";
    $index = $spotz->expect($timeout, $message);
    is($index, 1, "Welcome message line 2");
};

Then qr/^I should see the command prompt$/, func($context) {
    my $spotz = S->{'spotz'};
    my $index = $spotz->expect($timeout, 'spotz_editor>');
    is($index, 1, "Command prompt incorrect");
};

# vim: expandtab shiftwidth=4 softtabstop=4

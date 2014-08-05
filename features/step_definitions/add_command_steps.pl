use warnings;
use strict;

use Test::More;
use Test::BDD::Cucumber::StepFile;
use Method::Signatures;

use Expect;

When qr/^I enter "add"$/, func($context) {
    my $spotz = S->{'object'};
    my $answer = "add";
    $spotz->send("$answer\n");
    is($spotz->match_number(), 1, "Add command entry");

    $context->stash->{'scenario'}->{'add_entry_overview'} = [];
};

Then qr/^I should be prompted for the location's name$/, func($context) {
    my $spotz = S->{'object'};
    my $prompt = "Please enter the location's name:";
    my $index = $spotz->expect(1, $prompt);
    is($index, 1, "Location name prompt");
};

When qr/^I enter the location's name$/, func($context) {
    my $spotz = S->{'object'};
    my $answer = "Cafe with WLAN";
    $spotz->send("$answer\n");
    is($spotz->match_number(), 1, "Location name entry");

    push $context->stash->{'scenario'}->{'add_entry_overview'}, $answer;
};

Then qr/^I should be prompted for the type of location$/, func($context) {
    my $spotz = S->{'object'};
    my $prompt = "Please enter location's type (cafe, bar, restaurant):";
    my $index = $spotz->expect(1, $prompt);
    is($index, 1, "Location type prompt");
};

When qr/^I enter the location's type$/, func($context) {
    my $spotz = S->{'object'};
    my $answer = "cafe";
    $spotz->send("$answer\n");
    is($spotz->match_number(), 1, "Location type entry");

    push $context->stash->{'scenario'}->{'add_entry_overview'}, $answer;
};

Then qr/^I should be prompted for the location's SSID$/, func($context) {
    my $spotz = S->{'object'};
    my $prompt = "Please enter location's SSID:";
    my $index = $spotz->expect(1, $prompt);
    is($index, 1, "Location SSID prompt");
};

When qr/^I enter the location's SSID$/, func($context) {
    my $spotz = S->{'object'};
    my $answer = "CafeWLAN";
    $spotz->send("$answer\n");
    is($spotz->match_number(), 1, "Location SSID entry");

    push $context->stash->{'scenario'}->{'add_entry_overview'}, $answer;
};

Then qr/^I should be asked if the WLAN is free$/, func($context) {
    my $spotz = S->{'object'};
    my $prompt = "Is WLAN free here? (yes/no):";
    my $index = $spotz->expect(1, $prompt);
    is($index, 1, "Is WLAN free prompt");
};

When qr/^I enter yes$/, func($context) {
    my $spotz = S->{'object'};
    my $answer = "yes";
    $spotz->send("$answer\n");
    is($spotz->match_number(), 1, "Is WLAN free entry");

    push $context->stash->{'scenario'}->{'add_entry_overview'}, $answer;
};

Then qr/^I should be prompted for the location's street address$/,
    func($context) {
    my $spotz = S->{'object'};
    my $prompt = "Please enter the location's street address:";
    my $index = $spotz->expect(1, $prompt);
    is($index, 1, "Location street address prompt");
};

When qr/^I enter the location's street address$/, func($context) {
    my $spotz = S->{'object'};
    my $answer = "Unbekannter Weg 1";
    $spotz->send("$answer\n");
    is($spotz->match_number(), 1, "Location street address entry");

    push $context->stash->{'scenario'}->{'add_entry_overview'}, $answer;
};

Then qr/^I should be prompted for the location's URL$/, func($context) {
    my $spotz = S->{'object'};
    my $prompt = "Please enter the location's URL:";
    my $index = $spotz->expect(1, $prompt);
    is($index, 1, "Location URL prompt");
};

When qr/^I enter the location's URL$/, func($context) {
    my $spotz = S->{'object'};
    my $answer = "http://cafewlan.de";
    $spotz->send("$answer\n");
    is($spotz->match_number(), 1, "Location URL entry");

    push $context->stash->{'scenario'}->{'add_entry_overview'}, $answer;
};

Then qr/^I should be prompted for the location's latitude$/, func($context) {
    my $spotz = S->{'object'};
    my $prompt = "Please enter the location's latitude (in degrees):";
    my $index = $spotz->expect(1, $prompt);
    is($index, 1, "Location latitude prompt");
};

When qr/^I enter the location's latitude$/, func($context) {
    my $spotz = S->{'object'};
    my $answer = 50.123456;
    $spotz->send("$answer\n");
    is($spotz->match_number(), 1, "Location latitude entry");

    push $context->stash->{'scenario'}->{'add_entry_overview'}, $answer;
};

Then qr/^I should be prompted for the location's longitude$/, func($context) {
    my $spotz = S->{'object'};
    my $prompt = "Please enter the location's longitude (in degrees):";
    my $index = $spotz->expect(1, $prompt);
    is($index, 1, "Location longitude prompt");
};

When qr/^I enter the location's longitude$/, func($context) {
    my $spotz = S->{'object'};
    my $answer = 9.654321;
    $spotz->send("$answer\n");
    is($spotz->match_number(), 1, "Location longitude entry");

    push $context->stash->{'scenario'}->{'add_entry_overview'}, $answer;
};

Then qr/^I should be asked about power points$/, func($context) {
    my $spotz = S->{'object'};
    my $prompt = "Please enter notes about location's power points:";
    my $index = $spotz->expect(1, $prompt);
    is($index, 1, "Power points prompt");
};

When qr/^I enter notes about power points$/, func($context) {
    my $spotz = S->{'object'};
    my $answer = "Upstairs, in the corner";
    $spotz->send("$answer\n");
    is($spotz->match_number(), 1, "Power points entry");

    push $context->stash->{'scenario'}->{'add_entry_overview'}, $answer;
};

Then qr/^I should be asked about the network speed$/, func($context) {
    my $spotz = S->{'object'};
    my $prompt = "Please enter notes about location's network speed:";
    my $index = $spotz->expect(1, $prompt);
    is($index, 1, "Network speed prompt");
};

When qr/^I enter notes about the network speed$/, func($context) {
    my $spotz = S->{'object'};
    my $answer = "Good; 500kbs download; 200kbs upload";
    $spotz->send("$answer\n");
    is($spotz->match_number(), 1, "Network speed entry");

    push $context->stash->{'scenario'}->{'add_entry_overview'}, $answer;
};

Then qr/^I should be asked for extra notes$/, func($context) {
    my $spotz = S->{'object'};
    my $prompt = "Please enter extra notes about the location:";
    my $index = $spotz->expect(1, $prompt);
    is($index, 1, "Extra notes prompt");
};

When qr/^I enter extra notes$/, func($context) {
    my $spotz = S->{'object'};
    my $answer = "SSH blocked; HTTP(S) allowed";
    $spotz->send("$answer\n");
    is($spotz->match_number(), 1, "Extra notes entry");

    push $context->stash->{'scenario'}->{'add_entry_overview'}, $answer;
};

Then qr/^I should see an overview of the entered information$/, func($context) {
    my $spotz = S->{'object'};
    my $message = "Entry information:";
    my $index = $spotz->expect(1, $message);
    is($index, 1, "Entry information overview");

    my @add_entry_overview =
        @{$context->stash->{'scenario'}->{'add_entry_overview'}};
    print join "\n", @add_entry_overview;
    for my $entry ( @add_entry_overview ) {
        $index = $spotz->expect(1, $entry);
        is($index, 1, "Entry overview: $entry");
    }
};

When qr/^I add a new entry$/, func($context) {
    my $spotz = S->{'object'};
    my @add_entry_overview = [];
    $spotz->send("add\n");

    my $prompt = "Please enter the location's name:";
    $spotz->expect(1, $prompt);

    my $answer = "Cafe with WLAN";
    $spotz->send("$answer\n");
    push @add_entry_overview, $answer;

    $prompt = "Please enter location's type (cafe, bar, restaurant):";
    $spotz->expect(1, $prompt);

    $answer = "cafe";
    $spotz->send("$answer\n");
    push @add_entry_overview, $answer;

    $prompt = "Please enter location's SSID:";
    $spotz->expect(1, $prompt);

    $answer = "CafeWLAN";
    $spotz->send("$answer\n");
    push @add_entry_overview, $answer;

    $prompt = "Is WLAN free here? (yes/no):";
    $spotz->expect(1, $prompt);

    $answer = "yes";
    $spotz->send("$answer\n");
    push @add_entry_overview, $answer;

    $prompt = "Please enter the location's street address:";
    $spotz->expect(1, $prompt);

    $answer = "Unbekannter Weg 1";
    $spotz->send("$answer\n");
    push @add_entry_overview, $answer;

    $prompt = "Please enter the location's URL:";
    $spotz->expect(1, $prompt);

    $answer = "http://cafewlan.de";
    $spotz->send("$answer\n");
    push @add_entry_overview, $answer;

    $prompt = "Please enter the location's latitude (in degrees):";
    $spotz->expect(1, $prompt);

    $answer = 50.123456;
    $spotz->send("$answer\n");
    push @add_entry_overview, $answer;

    $prompt = "Please enter the location's longitude (in degrees):";
    $spotz->expect(1, $prompt);

    $answer = 9.654321;
    $spotz->send("$answer\n");
    push @add_entry_overview, $answer;

    $prompt = "Please enter notes about location's power points:";
    $spotz->expect(1, $prompt);

    $answer = "Upstairs, in the corner";
    $spotz->send("$answer\n");
    push @add_entry_overview, $answer;

    $prompt = "Please enter notes about location's network speed:";
    $spotz->expect(1, $prompt);

    $answer = "Good; 500kbs download; 200kbs upload";
    $spotz->send("$answer\n");
    push @add_entry_overview, $answer;

    $prompt = "Please enter extra notes about the location:";
    $spotz->expect(1, $prompt);

    $answer = "SSH blocked; HTTP(S) allowed";
    $spotz->send("$answer\n");
    push @add_entry_overview, $answer;

    my $message = "Entry information:";
    my $index = $spotz->expect(1, $message);
    is($index, 1, "Entry information overview");

    print join "\n", @add_entry_overview;
    for my $entry ( @add_entry_overview ) {
        $index = $spotz->expect(1, $entry);
        is($index, 1, "Entry overview: $entry");
    }
};

Then qr/^I should see the new entry in the output$/, func($context) {
    ok(0);
};

# vim: expandtab shiftwidth=4 softtabstop=4

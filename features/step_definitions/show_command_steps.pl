use warnings;
use strict;

use Test::More;
use Test::BDD::Cucumber::StepFile;
use Method::Signatures;

our $timeout = 2;

After sub {
    my $context = shift;
    my @test_files = qw( test.json empty_test.json);
    for my $test_file ( @test_files ) {
        unlink $test_file;
        ok( not -e $test_file );
    }
};

# No entries to show
Given qr/^there are no entries$/, func($context) {
    my $spotz = S->{'spotz'};
    create_empty_json_file();
    $spotz->send("load empty_test.json\n");
    ok( -f "empty_test.json", "Empty input file created" );
};

Then qr/^I should see a warning about no entries$/, func($context) {
    my $spotz = S->{'spotz'};
    my $entry_index = $context->stash->{'scenario'}->{'entry_index'};
    my $index = $spotz->expect($timeout, "Entry at index $entry_index not found");
    is($index, 1, "Empty input file error message");
};

# entries to show
When qr/^I enter \"show\" for entry \[(\d+)\]$/, func($context) {
    my $entry_index = $1;
    my $spotz = S->{'spotz'};
    $spotz->send("show $entry_index\n");
    $context->stash->{'scenario'}->{'entry_index'} = $entry_index;
    is($spotz->match_number(), 1, "Show command entry");
};

Then qr/^I should see all information for the given entry$/, func($context) {
    my $spotz = S->{'spotz'};

    my $index = $spotz->expect($timeout, '-re', qr{Name:\s+Cafe Spandau});
    is($index, 1, "Show command output: name");

    $index = $spotz->expect($timeout, '-re', qr{Type:\s+Cafe});
    is($index, 1, "Show command output: type");

    $index = $spotz->expect($timeout, '-re', qr{SSID:\s+SPANDAU_G});
    is($index, 1, "Show command output: ssid");

    $index = $spotz->expect($timeout, '-re', qr{Free WLAN\?:\s+yes});
    is($index, 1, "Show command output: free wlan?");

    $index = $spotz->expect($timeout, '-re', qr{Street address:\s+Engelbosteler Damm 30});
    is($index, 1, "Show command output: street address");

    $index = $spotz->expect($timeout, '-re', qr{URL:\s+http://www.spandau-projekt.de/});
    is($index, 1, "Show command output: url");

    $index = $spotz->expect($timeout, '-re', qr{Coordinates:\s+9.725181E, 52.384377N});
    is($index, 1, "Show command output: coordinates");

    $index = $spotz->expect($timeout, '-re', qr{Power points info:\s+});
    is($index, 1, "Show command output: power points");

    $index = $spotz->expect($timeout, '-re', qr{Network speed info:\s+good});
    is($index, 1, "Show command output: network speed");

    $index = $spotz->expect($timeout, '-re', qr{Extra info:\s+});
    is($index, 1, "Show command output: extra info");

    $index = $spotz->expect($timeout, '-re', qr{Last update:\s+});
    is($index, 1, "Show command output: last update");
};

sub create_empty_json_file {
    open my $fh, ">", "empty_test.json" or die "$!";
    print $fh <<EOF;
{
    "type": "FeatureCollection",
    "features": []
}
EOF
    close $fh;
}

# vim: expandtab shiftwidth=4 softtabstop=4

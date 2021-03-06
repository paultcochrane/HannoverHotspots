use warnings;
use strict;

use Test::More;
use Test::BDD::Cucumber::StepFile;
use Method::Signatures;

our $timeout = 2;

Given qr/^I have explicitly loaded a location file$/, func($context) {
    my $spotz = S->{'spotz'};
    create_test_json_file();
    $spotz->send("load test.json\n");
    is($spotz->match_number(), 1, "Load command entry");
};

When qr/^I enter \"load\" with an existing filename$/, func($context) {
    my $spotz = S->{'spotz'};
    create_test_json_file();
    $spotz->send("load test.json\n");
    is($spotz->match_number(), 1, "Load command entry");
};

Then qr/^I should see the entries in the loaded file$/, func($context) {
    my $spotz = S->{'spotz'};
    my $index = $spotz->expect($timeout, "Lindens Centrum");
    is($index, 1, "Display entry from explicitly loaded file");
    $index = $spotz->expect($timeout, "Cafe Spandau");
    is($index, 1, "Display entry from explicitly loaded file");
};

When qr/^I reload the location file$/, func($context) {
    my $spotz = S->{'spotz'};
    $spotz->send("load test.json\n");
    is($spotz->match_number(), 1, "Reload location file");
};

Then qr/^I should see the new entry in the output$/, func($context) {
    my $spotz = S->{'spotz'};
    my $index = $spotz->expect($timeout, '-re', qr/\[\d+\] Cafe with WLAN/);
    is($index, 1, "New location added");
};

sub create_test_json_file {
    open my $fh, ">", "test.json" or die "$!";
    print $fh <<EOF;
{
    "type": "FeatureCollection",
    "features": [
        {
            "type": "Feature",
            "geometry": {
                "type": "Point",
                "coordinates": [
                    9.714223, 52.367205
                    ]
            },
            "properties": {
                "marker-symbol": "bar",
                "marker-color": "00ff00",
                "title" : "Lindens Centrum",
                "name" : "Lindens Centrum",
		"type" : "Bar",
                "address" : "Lindener Marktplatz 3",
                "ssid" : "LindenerCentrum",
                "password" : "Ask the friendly staff",
                "wlan_is_free" : "yes",
                "speed" : "good",
                "url"  : "http://www.lindens-centrum.de/",
                "power_points" : "",
                "last_update" : "2014-05-30"
            }
        },
        {
            "type": "Feature",
            "geometry": {
                "type": "Point",
                "coordinates": [
                    9.725181, 52.384377
                    ]
            },
            "properties" : {
                "marker-symbol": "cafe",
                "marker-color": "00ff00",
                "name" : "Cafe Spandau",
		"type" : "Cafe",
                "address" : "Engelbosteler Damm 30",
                "ssid" : "SPANDAU_G",
                "password" : "Ask the friendly staff",
                "wlan_is_free" : "yes",
                "speed" : "good",
                "url" : "http://www.spandau-projekt.de/",
                "power_points" : "",
                "last_update" : ""
            }
        }
    ]
}
EOF
    close $fh;
}

# vim: expandtab shiftwidth=4 softtabstop=4

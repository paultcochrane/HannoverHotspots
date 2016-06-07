use warnings;
use strict;

use ExtUtils::MakeMaker;

WriteMakefile(
    NAME           => 'App::Hotspotz',
    VERSION_FROM   => 'lib/App/Hotspotz.pm',
    BUILD_REQUIRES => {
        "ExtUtils::MakeMaker"   => 0,
        "Moose"                 => 0,
        "Term::ReadLine::Perl5" => 0,
        "JSON"                  => 0,
        "Carp"                  => 0,
        "autodie"               => 0,
        "HTTP::Request::Common" => 0,
        "LWP::UserAgent"        => 0,
        "Pod::Usage"            => 0,
    },
    TEST_REQUIRES => {
        "Expect"              => 0,
        "Test::More"          => 0,
        "Test::BDD::Cucumber" => 0,
        "Method::Signatures"  => 0,
        "Capture::Tiny"       => 0,
    },
);

sub MY::postamble {
    return <<'MAKE_FRAG';
check_json:
	bin/check_geojson.pl

accept:
	pherkin -l -t ~@wip

unittest:
	prove -lr t

podchecker:
	podchecker bin/hotzen_spotz

tags:
	ctags --recurse
MAKE_FRAG
}

# vim: expandtab shiftwidth=4

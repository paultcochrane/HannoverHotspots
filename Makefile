.PHONY: check_json acceptance tags

test: check_json accept podchecker

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

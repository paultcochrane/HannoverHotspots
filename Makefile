.PHONY: check_json acceptance

test: check_json accept podchecker

check_json:
	bin/check_geojson.pl

accept:
	pherkin -t ~@wip

podchecker:
	podchecker bin/hotzen_spotz

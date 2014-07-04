.PHONY: check_json acceptance

test: check_json accept podchecker

check_json:
	python bin/check_geojson.py

accept:
	pherkin -t ~wip

podchecker:
	podchecker bin/hotzen_spotz

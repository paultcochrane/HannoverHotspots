.PHONY: check_json acceptance

test: check_json acceptance

check_json:
	python bin/check_geojson.py

acceptance:
	behave -t ~wip

.PHONY: check_json acceptance

test: check_json accept

check_json:
	python bin/check_geojson.py

accept:
	behave -t ~wip

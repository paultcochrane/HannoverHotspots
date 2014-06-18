.PHONY: check_json

test: check_json acceptance

check_json:
	python bin/check_geojson.py

acceptance:
	behave

.PHONY: check_json

test: check_json

check_json:
	python bin/check_geojson.py

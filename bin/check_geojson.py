#!/usr/bin/env python
# -*- coding: utf-8 -*-

import requests
import sys

def load_json():
    json_fh = open("hannover_hotspots.json", "r")
    hotspots_json = ''.join(json_fh.readlines())
    json_fh.close()

    return hotspots_json

def validate_json(hotspots_json):
    validate_endpoint = 'http://geojsonlint.com/validate'
    request = requests.post(validate_endpoint, data=hotspots_json)

    return request.json()

def print_validation_info(validation_result):
    ok_status = {u'status':u'ok'}

    if validation_result == ok_status:
        print "Valid geoJSON.  Now you can submit a pull request!"
        sys.exit(0)
    else:
        print "Invalid geoJSON.  Please correct and check again."
        sys.exit(255)

if __name__ == "__main__":
    hotspots_json = load_json()
    validation_result = validate_json(hotspots_json)
    print_validation_info(validation_result)

# vim: expandtab shiftwidth=4 softtabstop=4

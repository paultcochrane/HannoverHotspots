# Hannover Hotspots

<a href="https://travis-ci.org/paultcochrane/HannoverHotspots">
<img src="https://travis-ci.org/paultcochrane/HannoverHotspots.svg?branch=master">
</a>

Which cafes and pubs in Hannover have wireless internet?

## [Hannover Hotspot Map](https://github.com/paultcochrane/HannoverHotspots/blob/master/hannover_hotspots.json)

## How to contribute?

  1. fork the repository
  2. add a new entry or edit an existing one
  3. check that the geoJSON works, either
    * see http://geojsonlint.com/, or
    * run `make check_geojson`, or
    * run the test script `bin/check_geojson.pl`
  4. submit a pull request

## Project Dependencies

The entire project can be tested by simply running

    $ make test

However, before doing so, you'll need to install some Perl modules:

    $ cpanm --installdeps .

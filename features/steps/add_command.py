# -*- coding: utf-8 -*-

from behave import when, then
from nose.tools import assert_true, assert_equal

@when(u'I enter "add"')
def i_enter_add(context):
    bytes_sent = context.spotz.sendline("add")
    assert_equal(bytes_sent, 4)

    prompt_text = "spotz_editor> add"
    index = context.spotz.expect_exact(prompt_text)
    assert_equal(index, 0)

    output = context.spotz.match.strip('\r\n')
    assert_equal(output, prompt_text)

    context.add_entry_overview = []

@then(u'I should be prompted for the location\'s name')
def prompt_for_location_name(context):
    add_prompt_text = "Please enter location's name: "
    index = output = context.spotz.expect_exact(add_prompt_text)
    assert_equal(index, 0)

    output = context.spotz.match.strip('\r\n')
    assert_equal(output, add_prompt_text)

@when(u'I enter the location\'s name')
def enter_location_name(context):
    bytes_sent = context.spotz.sendline("Cafe with WLAN")
    assert_equal(bytes_sent, 15)

    assert_true(context.spotz.isalive())

@then(u'I should be prompted for the type of location')
def prompt_for_location_type(context):
    location_type_prompt = \
            "Please enter location's type (cafe, bar, restaurant): "
    index = context.spotz.expect_exact(location_type_prompt)
    assert_equal(index, 0)

    output = context.spotz.match.strip('\r\n')
    assert_equal(output, location_type_prompt)

@when(u'I enter the location\'s type')
def enter_location_type(context):
    bytes_sent = context.spotz.sendline("cafe")
    assert_equal(bytes_sent, 5)

    assert_true(context.spotz.isalive())

@then(u'I should be prompted for the location\'s SSID')
def prompt_for_location_ssid(context):
    location_ssid_prompt = "Please enter location's SSID: "
    index = context.spotz.expect_exact(location_ssid_prompt)
    assert_equal(index, 0)

    output = context.spotz.match.strip('\r\n')
    assert_equal(output, location_ssid_prompt)

@when(u'I enter the location\'s SSID')
def enter_location_ssid(context):
    bytes_sent = context.spotz.sendline("CafeWLAN")
    assert_equal(bytes_sent, 9)

    assert_true(context.spotz.isalive())

@then(u'I should be asked if the WLAN is free')
def ask_if_wlan_is_free(context):
    wlan_free_prompt = "Is WLAN free here? (yes/no): "
    index = context.spotz.expect_exact(wlan_free_prompt)
    assert_equal(index, 0)

    output = context.spotz.match.strip('\r\n')
    assert_equal(output, wlan_free_prompt)

@when(u'I enter yes or no')
def enter_yes_or_no(context):
    bytes_sent = context.spotz.sendline("yes")
    assert_equal(bytes_sent, 4)

    assert_true(context.spotz.isalive())

@then(u'I should be prompted for the location\'s street address')
def prompt_for_location_street_address(context):
    street_address_prompt = "Please enter the location's street address: "
    index = context.spotz.expect_exact(street_address_prompt)
    assert_equal(index, 0)

    output = context.spotz.match.strip('\r\n')
    assert_equal(output, street_address_prompt)

@when(u'I enter the location\'s street address')
def enter_location_street_address(context):
    bytes_sent = context.spotz.sendline("Unbekannter Weg 1")
    assert_equal(bytes_sent, 18)

    assert_true(context.spotz.isalive())

@then(u'I should be prompted for the location\'s URL')
def prompt_for_location_url(context):
    location_url_prompt = "Please enter the location's URL: "
    index = context.spotz.expect_exact(location_url_prompt)
    assert_equal(index, 0)

    output = context.spotz.match.strip('\r\n')
    assert_equal(output, location_url_prompt)

@when(u'I enter the location\'s URL')
def enter_location_url(context):
    bytes_sent = context.spotz.sendline("http://cafewlan.de")
    assert_equal(bytes_sent, 19)

    assert_true(context.spotz.isalive())

@then(u'I should be prompted for the location\'s latitude')
def prompt_for_location_latitude(context):
    latitude_prompt = "Please enter the location's latitude (in degrees): "
    index = context.spotz.expect_exact(latitude_prompt)
    assert_equal(index, 0)

    output = context.spotz.match.strip('\r\n')
    assert_equal(output, latitude_prompt)

@when(u'I enter the location\'s latitude')
def enter_location_latitude(context):
    bytes_sent = context.spotz.sendline("50.123456")
    assert_equal(bytes_sent, 10)

    assert_true(context.spotz.isalive())

@then(u'I should be prompted for the location\'s longitude')
def prompt_for_location_longitude(context):
    longitude_prompt = "Please enter the location's longitude (in degrees): "
    index = context.spotz.expect_exact(longitude_prompt)
    assert_equal(index, 0)

    output = context.spotz.match.strip('\r\n')
    assert_equal(output, longitude_prompt)

@when(u'I enter the location\'s longitude')
def enter_location_longitude(context):
    bytes_sent = context.spotz.sendline("9.654321")
    assert_equal(bytes_sent, 9)

    assert_true(context.spotz.isalive())

@then(u'I should be asked about power points')
def ask_about_power_points(context):
    power_points_prompt = "Please enter notes about location's power points: "
    index = context.spotz.expect_exact(power_points_prompt)
    assert_equal(index, 0)

    output = context.spotz.match.strip('\r\n')
    assert_equal(output, power_points_prompt)

@when(u'I enter notes about power points')
def enter_power_points_notes(context):
    bytes_sent = context.spotz.sendline("Upstairs, in the corner")
    assert_equal(bytes_sent, 24)

    assert_true(context.spotz.isalive())

@then(u'I should be asked about the network speed')
def ask_about_network_speed(context):
    network_speed_prompt = "Please enter notes about location's network speed: "
    index = context.spotz.expect_exact(network_speed_prompt)
    assert_equal(index, 0)

    output = context.spotz.match.strip('\r\n')
    assert_equal(output, network_speed_prompt)

@when(u'I enter notes about the network speed')
def enter_network_speed_notes(context):
    bytes_sent = context.spotz.sendline("Good; 500kbs download; 200kbs upload")
    assert_equal(bytes_sent, 37)

    assert_true(context.spotz.isalive())

@then(u'I should be asked for extra notes')
def ask_for_extra_notes(context):
    extra_notes_prompt = "Please enter extra notes about the location: "
    index = context.spotz.expect_exact(extra_notes_prompt)
    assert_equal(index, 0)

    output = context.spotz.match.strip('\r\n')
    assert_equal(output, extra_notes_prompt)

@when(u'I enter extra notes')
def enter_extra_notes(context):
    bytes_sent = context.spotz.sendline("SSH blocked; HTTP(S) allowed")
    assert_equal(bytes_sent, 29)

    assert_true(context.spotz.isalive())

@then(u'I should see an overview of the entered information')
def show_entry_overview(context):
    assert False

# vim: expandtab shiftwidth=4 softtabstop=4

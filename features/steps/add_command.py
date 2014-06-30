# -*- coding: utf-8 -*-

from behave import when, then
from nose.tools import assert_true, assert_equal

@when(u'I enter "add"')
def i_enter_add(context):
    bytes_sent = context.spotz.sendline("add")
    assert_equal(bytes_sent, 4)

    context.spotz.sendline("") # flush
    assert_true(context.spotz.isalive())

    output = context.spotz.readline()
    assert_equal(output.strip(), "")

    output = context.spotz.readline()
    assert_equal(output.strip(), "spotz_editor> add")

@then(u'I should be prompted for the location\'s name')
def prompt_for_location_name(context):
    add_prompt_text = "Please enter location's name: "
    output = context.spotz.readline()
    assert_equal(output.strip('\r\n'), add_prompt_text)

@when(u'I enter the location\'s name')
def enter_location_name(context):
    bytes_sent = context.spotz.sendline("Cafe with WLAN")
    assert_equal(bytes_sent, 15)

    assert_true(context.spotz.isalive())

@then(u'I should be prompted for the type of location')
def prompt_from_location_type(context):
    location_type_prompt = \
            "Please enter location's type (cafe, bar, restaurant): "
    index = context.spotz.expect_exact(location_type_prompt)
    assert_equal(index, 0)

    output = context.spotz.match.strip('\r\n')
    assert_equal(output, location_type_prompt)

# vim: expandtab shiftwidth=4 softtabstop=4

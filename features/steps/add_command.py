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

@then(u'I should be prompted for the cafe\'s name')
def prompt_for_cafes_name(context):
    add_prompt_text = "Please enter cafe/bar's name: "
    output = context.spotz.readline()
    assert_equal(output.strip('\r\n'), add_prompt_text)

# vim: expandtab shiftwidth=4 softtabstop=4

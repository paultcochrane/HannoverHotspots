# -*- coding: utf-8 -*-

from behave import given, then
from nose.tools import assert_false, assert_equal, assert_regexp_matches
import pexpect
import re

@given(u'the program hotzen_spotz is run')
def hotzen_spotz_is_run(context):
    process = pexpect.spawn("python -u bin/hotzen_spotz")

    context.process = process
    assert_false(process.eof())

@then(u'I should see the welcome screen')
def see_welcome_screen(context):
    welcome_message = context.text.strip().split('\n')[:2]
    output = context.process.readline().strip()

    assert_equal(output, welcome_message[0])

    output = context.process.readline().strip()
    assert_equal(output, welcome_message[1])

@then(u'I should see the command prompt')
def see_command_prompt(context):
    output = context.process.readline().strip()

    assert_equal(output, "")

    context.process.sendline("")  # flush the command line
    output = context.process.readline().strip()
    regexp = re.compile(".*%s.*" % context.text, re.MULTILINE)

    assert_regexp_matches(output, regexp)

# vim: expandtab shiftwidth=4 softtabstop=4

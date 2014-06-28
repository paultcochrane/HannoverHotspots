# -*- coding: utf-8 -*-

from behave import given, then
from nose.tools import assert_true, assert_equal
import pexpect

@given(u'the program hotzen_spotz is run')
def hotzen_spotz_is_run(context):
    spotz = pexpect.spawn("python -u bin/hotzen_spotz")
    context.spotz = spotz
    assert_true(spotz.isalive())

@then(u'I should see the welcome screen')
@given(u'I have seen the welcome screen')
def see_welcome_screen(context):
    welcome_message = """\
Welcome to the Hannover Hotspot editor, version 0.1
Use Ctrl+D to exit, type 'help' or '?' for help.
    """
    welcome_message = welcome_message.split('\n')
    output = context.spotz.readline().strip()
    assert_equal(output, welcome_message[0])

    output = context.spotz.readline().strip()
    assert_equal(output, welcome_message[1])

@then(u'I should see the command prompt')
def see_command_prompt(context):
    output = context.spotz.readline().strip()
    assert_equal(output, "")

    context.spotz.sendline("")  # flush the command line
    output = context.spotz.readline().strip('\r\n')
    command_prompt = "spotz_editor> "
    assert_equal(output, command_prompt)

# vim: expandtab shiftwidth=4 softtabstop=4

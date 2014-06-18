# -*- coding: utf-8 -*-

from behave import given, then
from nose.tools import assert_equal, assert_regexp_matches
from subprocess import Popen, PIPE
import re

@given(u'the program hotzen_spotz is run')
def run_hotzen_spotz(context):
    process = Popen("bin/hotzen_spotz", shell=True,
            stdin=PIPE, stdout=PIPE, stderr=PIPE,
            close_fds=True)
    context.stdout, context.stderr = process.communicate()

    assert_equal(process.returncode, 0)

@then(u'I should see the welcome screen')
def see_welcome_screen(context):
    output = context.stdout.strip().split('\n')[:2]
    welcome_message = context.text.strip().split('\n')[:2]

    assert_equal(output[0], welcome_message[0])
    assert_equal(output[1], welcome_message[1])

@then(u'I should see the command prompt')
def see_command_prompt(context):
    output = context.stdout.strip()
    regexp = re.compile(".*%s.*" % context.text, re.MULTILINE)

    assert_regexp_matches(output, regexp)

# vim: expandtab shiftwidth=4 softtabstop=4

# -*- coding: utf-8 -*-

from behave import when, then
from subprocess import Popen, PIPE

@when(u'the program hotzen_spotz is run')
def run_hotzen_spotz(context):
    process = Popen("bin/hotzen_spotz", shell=True,
            stdin=PIPE, stdout=PIPE, stderr=PIPE,
            close_fds=True)
    context.stdout, context.stderr = process.communicate()

    assert process.returncode == 0

@then(u'I should see the welcome screen')
def see_welcome_screen(context):
    output = context.stdout.strip()

    assert output == context.text

# vim: expandtab shiftwidth=4 softtabstop=4

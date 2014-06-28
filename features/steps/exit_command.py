# -*- coding: utf-8 -*-

from behave import when, then
from nose.tools import assert_false, assert_equal

@when(u'I enter "exit"')
def i_enter_exit(context):
    bytes_sent = context.spotz.sendline("exit")
    assert_equal(bytes_sent, 5)

    context.spotz.sendline("") # flush
    assert_false(context.spotz.isalive())

@then(u'the program should exit cleanly')
def the_program_exits(context):
    assert_equal(context.spotz.exitstatus, 0)

# vim: expandtab shiftwidth=4 softtabstop=4

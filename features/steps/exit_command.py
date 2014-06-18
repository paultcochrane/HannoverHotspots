# -*- coding: utf-8 -*-

from behave import when, then

@when(u'I enter "exit"')
def i_enter_exit(context):
    assert False

@then(u'the program should exit cleanly')
def the_program_exits(context):
    assert False

# vim: expandtab shiftwidth=4 softtabstop=4

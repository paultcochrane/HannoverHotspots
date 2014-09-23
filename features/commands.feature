Feature: interactive commands
    As a user of hotzen spotz
    When I enter commands
    I want the program to respond to them appropriately

    Background:
        Given the program hotzen_spotz is run
        And I have seen the welcome screen

    Scenario: list command
        When I enter "list"
        Then I should see a list of available entries
        And I should see the command prompt

    Scenario: help command
        When I enter "help"
        Then I should see a list of available commands
        And I should see the command prompt

    Scenario: ask for help with a question mark
        When I enter "?"
        Then I should see a list of available commands
        And I should see the command prompt

    Scenario: load command
        When I enter "load" with an existing filename
        And I enter "list"
        Then I should see the entries in the loaded file

    Scenario: unknown command
        When I enter an unknown command
        Then I should be told that the command is unknown
        And I should see the command prompt

# vim: expandtab shiftwidth=4 softtabstop=4

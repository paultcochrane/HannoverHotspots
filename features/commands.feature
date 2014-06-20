Feature: interactive commands
    As a user of hotzen spotz
    When I enter commands
    I want the program to respond to them appropriately

    Background:
        Given the program hotzen_spotz is run
        And I have seen the welcome screen

    Scenario: exit command
        When I enter "exit"
        Then the program should exit cleanly

    Scenario: add command
        When I enter "add"
        Then I should be prompted for the cafe's name

# vim: expandtab shiftwidth=4 softtabstop=4

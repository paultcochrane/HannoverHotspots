Feature: exit command
    As a user of hotzen spotz
    When I enter the exit command
    I want the program to respond to it appropriately

    Background:
        Given the program hotzen_spotz is run
        And I have seen the welcome screen

    Scenario: exit command
        When I enter "exit"
        Then the program should exit cleanly

    Scenario: exit command, x shortcut
        When I enter "x"
        Then the program should exit cleanly

    Scenario: exit command, quit alternative
        When I enter "quit"
        Then the program should exit cleanly

    Scenario: exit command, q shortcut
        When I enter "q"
        Then the program should exit cleanly

# vim: expandtab shiftwidth=4 softtabstop=4

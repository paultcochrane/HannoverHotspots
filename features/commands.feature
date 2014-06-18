Feature: interactive commands
    As a user of hotzen spotz
    When I enter commands
    I want the program to respond to them appropriately

    @wip
    Scenario: exit command
        Given the program hotzen_spotz is run
        When I enter "exit"
        Then the program should exit cleanly

# vim: expandtab shiftwidth=4 softtabstop=4

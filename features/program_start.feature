Feature: Simple startup, display welcome
    As a user of the software
    When I start the program
    I want to see a welcome message

    Scenario: welcome screen
        Given the program hotzen_spotz is run
        Then I should see the welcome screen
        And I should see the command prompt

# vim: expandtab shiftwidth=4 softtabstop=4

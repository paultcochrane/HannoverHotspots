Feature: add command
    As a user of hotzen spotz
    When I enter the add command
    I want the program to respond to it appropriately

    Background:
        Given the program hotzen_spotz is run
        And I have seen the welcome screen

    Scenario: add command creates a new entry
        Given I have explicitly loaded a location file
        When I add a new entry
        And I enter "list"
        Then I should see the new entry in the output
        And I should see the command prompt

    Scenario: add command creates a persistent entry
        Given I have explicitly loaded a location file
        When I add a new entry
        And I reload the location file
        And I enter "list"
        Then I should see the new entry in the output
        And I should see the command prompt

# vim: expandtab shiftwidth=4 softtabstop=4

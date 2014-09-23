Feature: show command
    As a user of hotzen spotz
    When I enter the show command
    I want the program to respond to it appropriately

    Background:
        Given the program hotzen_spotz is run
        And I have seen the welcome screen

    Scenario: show command without entries
        Given there are no entries
        When I enter "show" for entry [2]
        Then I should see a warning about no entries

    Scenario: show command with at least one entry
        Given I have explicitly loaded a location file
        When I enter "show" for entry [2]
        Then I should see all information for the given entry

    Scenario: show command with an incorrect index
        Given I have explicitly loaded a location file
        When I enter "show" for entry [200]
        Then I should see a warning about no entries

# vim: expandtab shiftwidth=4 softtabstop=4

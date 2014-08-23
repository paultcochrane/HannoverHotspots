Feature: interactive commands
    As a user of hotzen spotz
    When I enter commands
    I want the program to respond to them appropriately

    Background:
        Given the program hotzen_spotz is run
        And I have seen the welcome screen

    @wip
    Scenario: delete command
        When I enter "delete"
        Then I should see a list of available entries
        And I should be asked which entry to delete
        When I specify an item to delete
        Then I should receive confirmation that the item was deleted
        And I should see the command prompt

    @wip
    Scenario: delete command on a non-existent entry
        Given I have explicitly loaded a location file
        When I enter "list"
        And I enter "delete" for entry [3]
        Then I should be told the entry couldn't be deleted
        And I should see the command prompt

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

    Scenario: load command
        When I enter "load" with an existing filename
        And I enter "list"
        Then I should see the entries in the loaded file

    Scenario: unknown command
        When I enter an unknown command
        Then I should be told that the command is unknown
        And I should see the command prompt

# vim: expandtab shiftwidth=4 softtabstop=4

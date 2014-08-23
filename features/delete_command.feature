Feature: delete command
    As a user of hotzen spotz
    When I enter the delete command
    I want the program to respond to it appropriately

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

# vim: expandtab shiftwidth=4 softtabstop=4

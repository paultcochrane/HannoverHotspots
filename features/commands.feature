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
        Then I should be prompted for the location's name
        When I enter the location's name
        Then I should be prompted for the type of location
        When I enter the location's type
        Then I should be prompted for the location's SSID
        When I enter the location's SSID
        Then I should be asked if the WLAN is free
        When I enter yes
        Then I should be prompted for the location's street address
        When I enter the location's street address
        Then I should be prompted for the location's URL
        When I enter the location's URL
        Then I should be prompted for the location's latitude
        When I enter the location's latitude
        Then I should be prompted for the location's longitude
        When I enter the location's longitude
        Then I should be asked about power points
        When I enter notes about power points
        Then I should be asked about the network speed
        When I enter notes about the network speed
        Then I should be asked for extra notes
        When I enter extra notes
        Then I should see an overview of the entered information
        And I should see the command prompt

# vim: expandtab shiftwidth=4 softtabstop=4

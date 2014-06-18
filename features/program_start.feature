Feature: Simple startup, display welcome
    As a user of the software
    When I start the program
    I want to see a welcome message

    Scenario: welcome screen
	When the program hotzen_spotz is run
	Then I should see the welcome screen
	    """
	    Welcome to the Hannover Hotspot editor, version 0.1
	    Use Ctrl+D to exit, type 'help' or '?' for help.
	    """
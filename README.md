ProtoTest.Corundum
==================

Ruby gem for creating functional-web automated tests using Selenium and Rspec.

## Corundum Framework Design Principles
* Uses Selenium and Rspec directly without intermediate technologies like Capybara, Cucumber, etc.
* Powerful tools for a knowledgeable developer to create advanced, comprehensive automated tests.
* Technologies such as: configurable values, diagnostic logging, reporting, and page-objects make for a robust testing solution.

## Installation

Add this line to your application's Gemfile:
    gem 'corundum'

And then execute the bundle install:
    $ bundle

Or install it as:
    $ gem install corundum

## API Cheatsheet
# Driver
* visit(url) - navigates current browser window to the given url
* quit - closes current driver session.
* current_url - returns the current url (string).
* current_domain - returns the current domain (site.abc).
* verify_url(url) - verifies the given string (url) is within the current domain (e.g. "google.com" is within www.google.com/gmail).
* execute_script(javascript, element) - executes the given javascript on the given element
* execute_script_driver(javascript) - executes the given javascript on the current browser window
* save_screenshot - captures a screenshot of the currently active browser
* open_new_window(url) - opens a new browser window and navigates to the given url
* close_window - closes the currently active browser window
* switch_to_window(title) - switches the driver to the browser window with the given title
* switch_to_next_window - switches the driver to the browser window NEXT in the order in which they were opened
* switch_to_main_window - switches the driver to the browser window FIRST in the order in which they were opened

# Element
* verify(optional_timeout) - test marks the verification as a failure, but proceeds until test is complete (and then fails), with optional timeout
* wait_until(optional_timeout) - test fails immediately if the verification fails, with optional timeout
* click - clicks on the element
* send_keys(keyboard_characters) - types into the element
* hover_over - hovers over the element with the mouse
* hover_away - hovers away from the element
* scroll_into_view - scrolls the element into view
* text - returns the text within the element (string)
* save_element_screenshot - saves a cropped screenshot of the element itself

# Element Verifications (combined with verify. and wait_until. above)
* text(words) - confirms the element contains the given text
* visible - confirms the element is visible to the user
* present - confirmed the element is present in the DOM
* not. - confirms the opposite of the verification following it (e.g. button.verify.not.visible)

# Config Options
* $reports_output = system pathway where reports will be written to (defaults to "Dir.home")
* $target_ip = location of remote computer targetted for test execution (defaults to "localhost")
* $browser = browser to execute tests within (defaults to firefox)
* $url = url to load when used (defaults to "www.google.com")
* $page_timeout = time to wait for a page to load (defaults to "30")
* $element_timeout = time to wait for an element to load (defaults to "15")
* $log_level = displays the cumulative logging statements (defaults to "info".  options are: "debug", "info", "warn", "error")
* $highlight_verifications = true/false activator of highlight elements in green upon verification (defaults to "true")
* $highlight_duration = duration of the above element highlighting in seconds (defaults to "0.100")
* $screenshot_on_failure = true/false activator of screenshot capture on moment of test failure (defaults to "true")
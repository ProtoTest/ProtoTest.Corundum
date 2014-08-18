ProtoTest.Corundum
==================

Ruby gem for creating functional-web automated tests using Selenium and Rspec.

|| Why "Corundum"? |
|---|---|
|![](https://github.com/ProtoTest/ProtoTest.Corundum/blob/master/img/corundum_logo_small.png) | Corundum is a crystalline form of aluminium oxide (Al2O3).  If a chromium impurity is present, the transparent crystal becomes tinted red, forming "ruby".  All other colors are called "sapphire". |

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
### Driver
* __visit(url)__ - navigates current browser window to the given url
* __quit__ - closes current driver session.
* __current_url__ - returns the current url (string).
* __current_domain__ - returns the current domain (site.abc).
* __verify_url(url)__ - verifies the given string (url) is within the current domain (e.g. "google.com" is within "www.google.com/gmail").
* __execute_script(javascript, element)__ - executes the given javascript on the given element
* __execute_script_driver(javascript)__ - executes the given javascript on the current browser window
* __save_screenshot__ - captures a screenshot of the currently active browser
* __open_new_window(url)__ - opens a new browser window and navigates to the given url
* __close_window__ - closes the currently active browser window
* __switch_to_window(title)__ - switches the driver to the browser window with the given title
* __switch_to_next_window__ - switches the driver to the browser window NEXT in the order in which they were opened
* __switch_to_main_window__ - switches the driver to the browser window FIRST in the order in which they were opened

### Element
* __verify(optional_timeout)__ - test marks the verification as a failure, but proceeds until test is complete (and then fails), with optional timeout
* __wait_until(optional_timeout)__ - test fails immediately if the verification fails, with optional timeout
* __click__ - clicks on the element
* __send_keys(keyboard_characters)__ - types into the element
* __hover_over__ - hovers over the element with the mouse
* __hover_away__ - hovers away from the element
* __scroll_into_view__ - scrolls the element into view
* __text__ - returns the text within the element (string)
* __save_element_screenshot__ - saves a cropped screenshot of the element itself

### Element Verifications (combined with verify. and wait_until. above)
* __text(words)__ - confirms the element contains the given text
* __visible__ - confirms the element is visible to the user
* __present__ - confirmed the element is present in the DOM
* __not.__ - confirms the opposite of the verification following it (e.g. button.verify.not.visible)

### Config Options
* __$reports_output__ = system pathway where reports will be written to (defaults to "Dir.home")
* __$target_ip__ = location of remote computer targetted for test execution (defaults to "localhost")
* __$browser__ = browser to execute tests within (defaults to firefox)
* __$url__ = url to load when used (defaults to "www.google.com")
* __$page_timeout__ = time to wait for a page to load (defaults to "30")
* __$element_timeout__ = time to wait for an element to load (defaults to "15")
* __$log_level__ = displays the cumulative logging statements (defaults to "info".  options are: "debug", "info", "warn", "error")
* __$highlight_verifications__ = true/false activator of highlight elements in green upon verification (defaults to "true")
* __$highlight_duration__ = duration of the above element highlighting in seconds (defaults to "0.100")
* __$screenshot_on_failure__ = true/false activator of screenshot capture on moment of test failure (defaults to "true")
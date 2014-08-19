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

Note: requires a local copy of the file, as it is not currently hosted online.

## API Cheatsheet
### Driver
|Command|Description|
|---|---|
|visit(url)|Navigates current browser window to the given url|
|quit|Closes current driver session|
|current_url|Returns the current url (string)|
|current_domain|Returns the current domain (site.abc)|
|verify_url(url)|Verifies the given string (url) is within the current domain (e.g. "google.com" is within "google.com/gmail")|
|execute_script(javascript, element)|Executes the given javascript on the given element|
|execute_script_driver(javascript)|Executes the given javascript on the current browser window|
|save_screenshot|Captures a screenshot of the currently active browser|
|open_new_window(url)|Opens a new browser window and navigates to the given url|
|close_window|Closes the currently active browser window|
|switch_to_window(title)|Switches the driver to the browser window with the given title|
|switch_to_next_window|Switches the driver to the browser window NEXT in the order in which they were opened|
|switch_to_main_window|Switches the driver to the browser window FIRST in the order in which they were opened|

### Element
|Command|Description|
|---|---|
|verify(optional_timeout)|Test marks the verification as a failure, but proceeds until test is complete (and then fails), with optional timeout|
|wait_until(optional_timeout)|Test fails immediately if the verification fails, with optional timeout|
|click|Clicks on the element|
|send_keys(keyboard_characters)|Types into the element|
|hover_over|Hovers over the element with the mouse|
|hover_away|Hovers away from the element|
|scroll_into_view|Scrolls the element into view|
|text|Returns the text within the element (string)|
|save_element_screenshot|Saves a cropped screenshot of the element itself|

### Element Verifications (combined with verify. and wait_until. above)
|Command|Description|
|---|---|
|text(words)|Confirms the element contains the given text
|visible|Confirms the element is visible to the user
|present|Confirmed the element is present in the DOM
|not.|Confirms the opposite of the verification following it (e.g. button.verify.not.visible)

### Config Options
|Command|Description|Defaults to|
|---|---|---|
|$reports_output|System pathway where reports will be written to|"Dir.home"|
|$target_ip|Location of remote computer targetted for test execution|"localhost"|
|$browser|Browser to execute tests within|Firefox|
|$url|Url to load when used|"www.google.com"|
|$page_timeout|Time to wait for a page to load|30 (seconds)|
|$element_timeout|Time to wait for an element to load|15 (seconds)|
|$log_level|Displays the cumulative logging statements|Default = "info".  Options are: "debug", "info", "warn", "error"|
|$highlight_verifications|True/false activator of highlight elements in green upon verification|true|
|$highlight_duration|Duration of the above element highlighting|0.100 (seconds)|
|$screenshot_on_failure|True/false activator of screenshot capture on moment of test failure|true|

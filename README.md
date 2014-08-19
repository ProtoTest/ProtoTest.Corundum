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

## Usage Example
***spec_helper.rb***
(config options single-point-of-entry for framework + page objects)
```ruby
# Config Options
$reports_output = (Dir.home.to_s + "/desktop")
$target_ip = 'localhost'
$browser = :firefox
$url = 'http://www.google.com'
$page_timeout = 30
$element_timeout = 15
$log_level = :debug
$highlight_verifications = true
$highlight_duration = 0.100
$screenshot_on_failure = true

# Framework Components
require 'corundum'

# Page Objects
require 'page_objects/spec_page_objects_list'
```

***google_home.rb***
(page object)
```ruby
require 'corundum'

class GoogleHome
  attr_reader :plus_you, :gmail_option, :images_option, :apps_option, :signin_button, :google_logo, :search_box, :search_button, :lucky_button

  def initialize
    @plus_you = Element.new('+You option', :xpath, "//a[@class='gb_d gb_f' and @data-pid='119']")
    @gmail_option = Element.new('Gmail option', :xpath, "//a[@class='gb_d' and @data-pid='23']")
    @images_option = Element.new('Images option', :xpath, "//a[@class='gb_d' and @data-pid='2']")
    @apps_option = Element.new('Apps option', :xpath, "//a[@title='Apps']")
    @signin_button = Element.new('Sign in option', :xpath, "//a[@id='gb_70']")
    @google_logo = Element.new('Google logo', :xpath, "//*[@id='hplogo']")
    @search_box = Element.new('Search box', :css, 'input.gbqfif')
    @search_button = Element.new('Search button', :css, '#gbqfba')
    @lucky_button = Element.new('Lucky button', :css, '#gbqfbb')
  end

  def search(text)
    Log.info("Searching for #{text} using Google search field...")
    @search_box.send_keys(text)
  end

end
```

***google_elements_spec.rb***
 (test)
```ruby
require 'spec_helper'

describe 'Google Elements spec' do
  include_context 'corundum'
  
  it 'Test 001 should verify the google lucky-button element text is correct' do
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new   #Google page object
    google_home.lucky_button.wait_until.visible
    google_home.lucky_button.verify.text("I'm Feeling Lucky")
    google_home.lucky_button.verify.not.text("I'm not Feeling Lucky!")
  end
  
end
```

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

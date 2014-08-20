# Add any spec enhancements or extra features here

# load the framework
require 'corundum'

# Page Objects
require 'page_objects/spec_page_objects_list'

# Setup any custom configuration for the Corundum framework
Corundum.configure do |config|
  config.report_dir = Dir.home.to_s + "/desktop"
  config.target_ip = "localhost"
  config.browser = :chrome
  config.url = "http://www.google.com"
  config.page_load_timeout = 15
  config.element_timeout = 15
  config.log_level = :info
  config.highlight_verifications = true
  config.highlight_duration = 0.100
  config.screenshot_on_failure = true
end
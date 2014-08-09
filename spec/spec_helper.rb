# Add any spec enhancements or extra features here

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

# Rspec Components
require 'corundum'

# Page Objects
require 'page_objects/spec_page_objects_list'
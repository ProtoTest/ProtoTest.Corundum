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

# Rspec Components
require 'rspec'
require 'rspec-expectations'
require 'corundum'

# Page Objects
require 'page_objects/spec_page_objects_list'
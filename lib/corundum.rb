require 'corundum/config'
require 'corundum/log'
require 'corundum/junit_reporter'
require 'corundum/custom_formatter'

require 'corundum/selenium/driver'
require 'corundum/selenium/driver_extensions'
require 'corundum/selenium/element'
require 'corundum/selenium/element_verification'
require 'corundum/selenium/event_listener'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib/corundum'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib/corundum/driver'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib/corundum/selenium'))
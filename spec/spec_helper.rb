$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib/corundum'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib/corundum/driver'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib/corundum/selenium'))

require 'corundum'
require 'custom_formatter'
require 'junit_reporter'

RSpec.configure do |config|
  # allow it so rspec test cases do not need to have values associated with tagging
  config.treat_symbols_as_metadata_keys_with_true_values = true

  config.add_formatter :documentation, 'output.txt'
  config.add_formatter CustomFormatter, 'output.html'
  config.add_formatter JunitReporter, 'output.xml'

  config.add_setting :screenshot_on_failure, :default => true
  config.add_setting :command_logging, :default => true
  config.add_setting :test_name, :default => 'Test'
  config.add_setting :command_delay_sec, :default => 0

  config.before(:all) do

  end

  config.after(:all) do

  end

  config.before(:each) do

  end

  config.after(:each) do

  end

end


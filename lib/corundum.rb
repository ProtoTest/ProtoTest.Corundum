$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib/corundum'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib/corundum/selenium'))

require 'config'
require 'logging'
require 'junit_reporter'
require 'custom_formatter'

require 'driver'
require 'driver_extensions'
require 'element'
require 'element_verification'
require 'event_listener'


require 'rspec'
require 'date'
require 'fileutils'
include Corundum::Selenium

shared_context 'corundum' do
  include Corundum
end

# Logger object
Log = Corundum::Logging::log

# Create the test report root directory
report_root_dir = File.expand_path(File.join(Corundum::Config::REPORTS_OUTPUT, 'Spec reports'))
Dir.mkdir(report_root_dir) if not File.exist?(report_root_dir)

# Create the sub-directory for the test suite run
current_run_report_dir = File.join(report_root_dir, "Spec_results__" + DateTime.now.strftime("%m-%d-%Y_%H_%M_%S"))
Dir.mkdir(current_run_report_dir)

# Add the current test run report directory to framework configuration
Corundum::Config::add_config_value(:REPORT_DIR, current_run_report_dir)

# Add the output log file for the rspec test run to the logger
Corundum::Logging::add_device(File.open(File.join(current_run_report_dir, "suite.log"), File::WRONLY | File::APPEND | File::CREAT))



RSpec.configure do |config|

  # Allow it so rspec test cases do not need to have values associated with tagging
  config.treat_symbols_as_metadata_keys_with_true_values = true

  config.add_formatter :documentation, File.join(current_run_report_dir, 'output.txt')
  config.add_formatter CustomFormatter, File.join(current_run_report_dir, 'output.html')
  config.add_formatter JunitReporter, File.join(current_run_report_dir, 'output.xml')

  config.add_setting :test_name, :default => 'Test'

  config.before(:all) do
  end

  config.after(:all) do
  end

  config.before(:each) do
    puts('')
    Log.info('BEGINNING NEW TEST')
    $verification_errors = []
  end

  config.after(:each) do
    # TODO: Create some test_data container to store all of this stuff related to the test run, then throw the verification errors in the HTML report

    Log.debug('Executing test cleanup...')
    Corundum::Selenium::Driver.quit

    Log.info('TEST COMPLETE')
  end

end
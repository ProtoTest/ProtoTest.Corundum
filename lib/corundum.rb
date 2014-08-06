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

  before(:all) do
  end

  after(:all) do
  end

  before(:each) do
    puts ("\n")
    Log.info('BEGINNING NEW TEST')
    $verification_errors = []
  end

  after(:each) do
    # TODO: Create some test_data container to store all of this stuff related to the test run, then throw the verification errors in the HTML report
    Log.debug('Executing test cleanup...')
    Corundum::Selenium::Driver.quit
    Log.info('TEST COMPLETE')
  end

end


# Logger object
Log = Corundum::Logging::log

# Create the test report root directory
report_root_dir = File.expand_path(File.join(Corundum::Config::REPORTS_OUTPUT, 'spec_reports'))
Dir.mkdir(report_root_dir) if not File.exist?(report_root_dir)

# Create the sub-directory for the test suite run
current_run_report_dir = File.join(report_root_dir, "spec_results__" + DateTime.now.strftime("%m_%d_%Y__%H_%M_%S"))
$current_run_dir = current_run_report_dir
Dir.mkdir(current_run_report_dir)

# Add the output log file for the rspec test run to the logger
Corundum::Logging::add_device(File.open(File.join(current_run_report_dir, "spec_logging_output.log"), File::WRONLY | File::APPEND | File::CREAT))


RSpec.configure do |config|

  # NOTE: rspec.configure can be executed multiple times and the below are additions to any user-generated options

  # Allow it so rspec test cases do not need to have values associated with tagging
  config.treat_symbols_as_metadata_keys_with_true_values = true

  config.add_formatter :documentation, File.join(current_run_report_dir, 'spec_execution_notes.txt')
  config.add_formatter CustomFormatter, File.join(current_run_report_dir, 'spec_results_report.html')
  config.add_formatter JunitReporter, File.join(current_run_report_dir, 'spec_execution_stats.xml')

  config.add_setting :test_name, :default => 'Test'

end
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib/corundum'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib/corundum/driver'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib/corundum/selenium'))

require 'date'
require 'fileutils'
require 'corundum'
require 'custom_formatter'
require 'junit_reporter'

RSpec.configure do |config|

  # Create the test report root directory
  report_root_dir = File.expand_path(File.join(File.dirname(__FILE__), 'reports'))
  Dir.mkdir(report_root_dir) if not File.exist?(report_root_dir)

  # Create the sub-directory for the test run
  REPORT_DIR = current_run_report_dir = File.join(report_root_dir, DateTime.now.strftime("%m-%d-%Y_%H_%M_%S"))
  Dir.mkdir(current_run_report_dir)

  # allow it so rspec test cases do not need to have values associated with tagging
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
    $verification_errors = []
  end

  config.after(:each) do
    # TODO: Create some test_data container to store all of this stuff related to the test run, then throw the verification errors in the HTML report

    # just a simple print to console
    if !$verification_errors.empty?
      puts "VERIFICATION ERRORS:"
      $verification_errors.each do |error|
        puts "-- #{error.error}"
      end
    end
  end

end


require 'rspec'
require 'corundum'
require 'custom_formatter'
require 'junit_reporter'
require 'date'
require 'fileutils'
include Corundum::Selenium

shared_context 'corundum context' do
  include Corundum

end

RSpec.configure do |config|

  # Create the test report root directory
  REPORT_ROOT = report_root_dir = File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec/reports'))
  Dir.mkdir(report_root_dir) if not File.exist?(report_root_dir)

  # Create the sub-directory for the test run
  REPORT_DIR = current_run_report_dir = File.join(report_root_dir, DateTime.now.strftime("%m_%d_%Y__%H_%M_%S"))
  Dir.mkdir(current_run_report_dir)

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
    Log.message('BEGINNING NEW TEST')
    $verification_errors = []
  end

  config.after(:each) do
    # TODO: Create some test_data container to store all of this stuff related to the test run, then throw the verification errors in the HTML report

    Log.message('Executing test cleanup...')
    Corundum::Selenium::Driver.quit

    Log.message('TEST COMPLETE')

  end

end
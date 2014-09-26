# Corundum core file allows a single point of access to all framework-related components

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib/corundum'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib/corundum/selenium'))

require 'config'
require 'log'
require 'junit_reporter'
require 'custom_formatter'

require 'driver'
require 'driver_extensions'
require 'element'
require 'element_extensions'
require 'element_verification'

require 'rspec'
require 'rspec-expectations'
require 'date'
require 'fileutils'
include Corundum::Selenium
include Corundum

shared_context 'corundum' do
  include Corundum



  RSpec.configure do |config|
    Log.info("Configuring Corundum's RSpec options...")
    # NOTE: rspec.configure can be executed multiple times and the below are additions to any user-generated options

    # Allow it so rspec test cases do not need to have values associated with tagging
    config.treat_symbols_as_metadata_keys_with_true_values = true

    config.add_formatter :documentation, 'spec_execution_notes.txt'
    config.add_formatter CustomFormatter, 'spec_results_report.html'
    config.add_formatter JunitReporter, 'spec_execution_stats.xml'

    config.add_setting :test_name, :default => 'Test'
  end

  before(:all) do
    # Create the test report root directory
    report_root_dir = File.expand_path(File.join(Corundum.config.report_dir, 'spec_reports'))
    Dir.mkdir(report_root_dir) if not File.exist?(report_root_dir)

    # Create the sub-directory for the test suite run
    current_run_report_dir = File.join(report_root_dir, "spec_results__" + DateTime.now.strftime("%m_%d_%Y__%H_%M_%S"))
    $current_run_dir = current_run_report_dir
    Dir.mkdir(current_run_report_dir)

    # Add the output log file for the rspec test run to the logger
    Log.add_device(File.open(File.join(current_run_report_dir, "spec_logging_output.log"), File::WRONLY | File::APPEND | File::CREAT))

    $verifications_total = 0
    $warnings_total = 0
    $errors_total = 0
    $execution_warnings = Array.new
    $verification_errors = Array.new
    $screenshots_message = Array.new
    $screenshots_captured = Array.new

    Log.info("BEGINNING TEST SUITE")
    Log.info("CREATING REPORT FOLDER @ #{$current_run_dir}")
    Log.info("TARGET MACHINE: #{Corundum.config.target_ip}\n")
  end

  before(:each) do
    Log.info("BEGINNING NEW TEST: #{example.description}")
    Log.info("BROWSER: #{Corundum.config.browser}")
    $verification_passes = 0
    $execution_warnings.clear
    $verification_errors.clear

    $test_flag_fail_instantly = false
    $test_flag_fail_end = false

    $screenshots_message.clear
    $screenshots_captured.clear
    $screenshots_data = {}
    $fail_screenshot = nil
  end

  after(:each) do
    Log.debug("Executing test cleanup...")
    Corundum::Selenium::Driver.quit

    if $test_flag_fail_instantly
      Log.info("TEST FAILED - CRITICAL ERROR DETECTED")
    elsif $test_flag_fail_end
      Log.info("TEST FAILED - VERIFICATION ERRORS DETECTED")
    else
      Log.info("TEST PASSED")
    end

    Log.info("Verifications confirmed: (#{$verification_passes} total).")
    $verifications_total += $verification_passes
    $warnings_total += $execution_warnings.length
    $errors_total += $verification_errors.length

    if $execution_warnings.empty?
      Log.info("No warnings detected during test run.")
    else
      Log.info("Warnings detected during test run: (#{$execution_warnings.length} total).")
      msg = "Warning detected during test execution:"
      $execution_warnings.each { |error_message| msg << "\n\t" + error_message }
    end

    if $verification_errors.empty?
      Log.info("No errors detected during test run.\n")
    else
      Log.info("Errors detected during test run: (#{$verification_errors.length} total).")
      msg = "TEST FAILURE: Errors detected during test execution:"
      $verification_errors.each { |error_message| msg << "\n\t" + error_message }
      Kernel.fail(msg)
    end

  end

  after(:all) do
    Log.info("TEST SUITE COMPLETE")
    Log.info("Verifications confirmed: (#{$verifications_total} total).")
    Log.info("Warnings detected: (#{$warnings_total} total).")
    Log.info("Errors detected: (#{$errors_total} total).")

    # cp the rspec generated files into the test report dir
    FileUtils.cp('spec_execution_notes.txt', $current_run_dir)
    FileUtils.cp('spec_results_report.html', $current_run_dir)
    FileUtils.cp('spec_execution_stats.xml', $current_run_dir)
  end

end
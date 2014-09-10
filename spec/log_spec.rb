require 'spec_helper'

describe 'Corundum logging spec' do
  include_context 'corundum'

  it 'Test 001 should use each of the logging statements' do
    Driver.visit('http://www.google.com')
    sleep 1
    Log.debug('Debug example text.')
    sleep 1
    Log.info('Info example text.')
    sleep 1
    Log.warn('Warning example text.')
    sleep 1
    Log.error('Error example text.')
    sleep 1
    Element.new('Verify element', :xpath, "//div[@id='shouldnotbeabletofindthis']").verify.present
    sleep 1
    Element.new('Verify element', :xpath, "//div[@id='shouldnotbeabletofindthistoo']").verify.present
    sleep 1
    Log.info("Errors caught as part of this test: (#{$verification_errors.length}).")
    $verification_errors.length.should eql(3)
    $verification_errors = []
    sleep 1
    Log.info('End of test.')
  end

  it 'Test 002 should use each of the screenshot captures' do
    Driver.visit('http://www.google.com')
    Driver.save_screenshot
    google_home = GoogleHome.new
    google_home.google_logo.save_element_screenshot
    $verification_passes.should eql(2)
  end

end
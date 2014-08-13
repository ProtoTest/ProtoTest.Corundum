require 'spec_helper'

describe 'Corundum logging spec' do
  include_context 'corundum'

  it 'Test 001 should use each of the logging statements' do
    sleep 1
    Log.debug('Debug example text.')
    sleep 1
    Log.info('Info example text.')
    sleep 1
    Log.warn('Warning example text.')
    sleep 1
    $verification_warnings.length.should eql(1)
    $verification_warnings = []
    $verification_passes.should eql(0)
    expect{Log.error('Error example text.')}.to raise_error
    sleep 1
  end

  it 'Test 002 should use each of the screenshot captures' do
    Driver.visit('http://www.google.com')
    Driver.save_screenshot
    google_home = GoogleHome.new
    google_home.google_logo.save_element_screenshot
    $verification_passes.should eql(2)
  end

end
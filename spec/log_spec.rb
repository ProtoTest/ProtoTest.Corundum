require 'spec_helper'
require 'corundum_context'

describe 'Corundum logging spec' do
  include_context 'corundum context'

  it 'Test 001 should use each of the logging statements' do
    Log.info(example.description)
    sleep 1
    Log.debug('Debug example text.')
    sleep 1
    Log.info('Info example text.')
    sleep 1
    Log.warning('Warning example text.')
    sleep 1
    expect {Log.error('Error example text.')}.to raise_error
    sleep 1
  end

  it 'Test 002 should use each of the logging captures' do
    Log.info(example.description)
    Driver.visit('http://www.google.com')
    Driver.save_screenshot
    google_home = GoogleHome.new
    google_home.google_logo.save_element_screenshot
  end

end
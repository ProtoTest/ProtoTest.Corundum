require 'rspec'
require 'spec_helper'
require 'page_objects/google_home'
require 'corundum_context'

describe 'Corundum logging spec' do
  include_context 'corundum context'

  it 'Test 001 should use each of the logging statements' do
    $log.info(example.description)
    $log.debug('Debug example text.')
    sleep 1
    $log.info('Info example text.')
    sleep 1
    $log.warning('Warning example text.')
    sleep 1
    expect {$log.error('Error example text.')}.to raise_error
  end

  it 'Test 002 should use each of the logging captures' do
    Logging.debug
    $log.info(example.description)
    Driver.visit('http://www.google.com')
    $log.capture_screenshot
    google_home = GoogleHome.new
    $log.capture_element(google_home.google_logo)
  end

end
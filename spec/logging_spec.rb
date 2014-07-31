require 'rspec'
require 'spec_helper'
require 'corundum_context'

describe 'Corundum logging spec' do
  include_context 'corundum context'

  it 'Test 001 should use each of the logging types' do
    $log.info(example.description)
    $log.debug('Debug example text.')
    sleep 1
    $log.info('Info example text.')
    sleep 1
    $log.warning('Warning example text.')
    sleep 1
    expect {$log.error('Error example text.')}.to raise_error
    sleep 1
    $log.capture_screenshot
  end

end
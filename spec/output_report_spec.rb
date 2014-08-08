require 'spec_helper'

describe 'Corundum output report spec' do
  include_context 'corundum'

  it 'Test 001 should pass' do
    sleep 1
  end

  it 'Test 002 should fail' do
    Driver.visit('http://www.google.com')
    Log.info('The following error is anticipated.')
    Element.new('Random element', :css, '#no_id').wait_until.visible
  end

  it 'Test 003 should fail' do
    Driver.visit('http://www.google.com')
    Log.info('The following error is anticipated.')
    Element.new('Random element', :css, '#no_id').wait_until.visible
  end

  it 'Test 004 should pass' do
    sleep 1
  end

  it 'Test 005 should pass' do
    sleep 1
  end

end
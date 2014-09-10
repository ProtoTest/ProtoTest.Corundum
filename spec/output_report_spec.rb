require 'spec_helper'

describe 'Corundum output report spec' do
  include_context 'corundum'

  it 'Test 001 should pass and take an extra screenshot' do
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new
    google_home.search('Test 01')
    Driver.save_screenshot('test')
  end

  it 'Test 002 should hard fail and capture a screenshot on failure' do
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new
    google_home.search('Test 02')
    Log.info('The following error is anticipated.')
    Element.new('Random element', :css, '#no_id').wait_until.visible
    Element.new('Random element', :xpath, '//*').wait_until.present
  end

  it 'Test 003 should soft fail and capture a screenshot on failure' do
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new
    google_home.search('Test 03')
    Log.info('The following error is anticipated.')
    Element.new('Random element', :css, '#no_id').verify.visible
    Element.new('Random element', :xpath, '//*').verify.present
  end

  it 'Test 004 should pass without a screenshot' do
    Log.debug('Debug example text.')
    sleep 1
    Log.info('Info example text.')
  end

  it 'Test 005 should pass and take an element screenshot, then a whole browser screenshot, and both again' do
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new
    google_home.google_logo.save_element_screenshot
    Driver.save_screenshot('test')
    google_home.search_button.save_element_screenshot
    google_home.search('Test 05')
    Driver.save_screenshot('test')
  end

  it 'Test 006 should pass without a screenshot' do
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new
    google_home.lucky_button.verify.text("I'm Feeling Lucky")
  end

end
require 'rspec'
require 'rspec-expectations'
require 'spec_helper'
require 'page_objects/google_home'
require 'page_objects/gmail_home'
require 'corundum_context'

describe 'Element spec' do
  include_context 'corundum context'

  it 'Test 001 should instantiate new Corundum Elements' do
    $log.info(example.description)
    Driver.visit('http://www.google.com')
    ele1 = Element.new('ele1', :css, '#gbqfq')
    ele1.send_keys 'prototest'
    ele2 = Element.new('ele2', :xpath, "//div[@id='search']//b[contains(.,'prototest')]")
    ele2.verify.present
  end

  it 'Test 002 should use an element from a page object' do
    $log.info(example.description)
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new
    google_home.search('prototest')
    ele = Element.new('ele2', :xpath, "//div[@id='search']//b[contains(.,'prototest')]")
    ele.verify.present
  end

  it 'Test 003 should verify a button element text is correct' do
    $log.info(example.description)
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new
    google_home.lucky_button.verify.text("I'm Feeling Lucky")
  end

  it 'Test 004 should verify the button element text is NOT correct' do
    $log.info(example.description)
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new
    google_home.lucky_button.verify.not.text("I'm not Feeling Lucky!")
  end

  it 'Test 005 should give a warning when verifying the button element text is NOT correct' do
    $log.info(example.description)
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new
    google_home.lucky_button.verify.text("I'm not Feeling Lucky!")
    google_home.lucky_button.verify.text("I'm Feeling Lucky")
  end

  it 'Test 006 should give a warning when verifying the button element text is correct despite using a (NOT) verification' do
    $log.info(example.description)
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new
    google_home.lucky_button.verify.not.text("I'm Feeling Lucky")
    google_home.lucky_button.verify.not.text("I'm not Feeling Lucky!")
  end

  it 'Test 007 should verify the button element is present' do
    $log.info(example.description)
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new
    google_home.lucky_button.verify.present
  end

  it 'Test 008 should verify an element not on the page is (NOT) present' do
    $log.info(example.description)
    Driver.visit('http://www.google.com')
    Element.new('Random element', :css, '#no_id').verify.not.present
  end

  it 'Test 009 should verify the button element is visible' do
    $log.info(example.description)
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new
    google_home.lucky_button.verify.visible
  end

  it 'Test 010 should verify an element not on the page is (NOT) visible' do
    $log.info(example.description)
    Driver.visit('http://www.google.com')
    Element.new('Random element', :css, '#no_id').verify.not.visible
  end

  it 'Test 011 should give a warning when verifying a button element is on the page when using a (NOT PRESENT) verification' do
    $log.info(example.description)
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new
    google_home.lucky_button.verify.not.present
  end

  it 'Test 012 should give a warning when verifying a button element is on the page when using a (NOT VISIBLE) verification' do
    $log.info(example.description)
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new
    google_home.lucky_button.verify.not.visible
  end

  it 'Test 013 should give a warning when verifying a non-existent element is on the page using a (PRESENT) verification' do
    $log.info(example.description)
    Driver.visit('http://www.google.com')
    Element.new('Random element', :css, '#no_id').verify.present
  end

  it 'Test 014 should give a warning when verifying a non-existent element is on the page using a (VISIBLE) verification' do
    $log.info(example.description)
    Driver.visit('http://www.google.com')
    Element.new('Random element', :css, '#no_id').verify.visible
  end

  it 'Test 015 should click on a page object element and confirm transition to new page object' do
    $log.info(example.description)
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new
    google_home.gmail_option.click
    gmail_home = GmailHome.new
    gmail_home.nav_gmail_icon.wait_until.present
  end

end
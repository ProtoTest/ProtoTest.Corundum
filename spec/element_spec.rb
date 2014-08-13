require 'spec_helper'

describe 'Corundum Element spec' do
  include_context 'corundum'

  it 'Test 001 should instantiate new Corundum Elements' do
    Driver.visit('http://www.google.com')
    ele1 = Element.new('ele1', :css, '#gbqfq')
    ele1.send_keys 'prototest'
    ele2 = Element.new('ele2', :xpath, "//div[@id='search']//b[contains(.,'prototest')]")
    ele2.verify.present
    $verification_passes.should eql(3)
  end

  it 'Test 002 should use an element from a page object' do
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new
    google_home.search('prototest')
    ele = Element.new('ele2', :xpath, "//div[@id='search']//b[contains(.,'prototest')]")
    ele.verify.present
    $verification_passes.should eql(3)
  end

  it 'Test 003 should verify a button element text is correct' do
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new
    google_home.lucky_button.verify.text("I'm Feeling Lucky")
    $verification_passes.should eql(3)
  end

  it 'Test 004 should verify the button element text is NOT correct' do
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new
    google_home.lucky_button.verify.not.text("I'm not Feeling Lucky!")
    $verification_passes.should eql(3)
  end

  it 'Test 005 should give a warning when verifying the button element text is NOT correct' do
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new
    google_home.lucky_button.verify.text("I'm not Feeling Lucky!")
    google_home.lucky_button.verify.text("I'm Feeling Lucky")
    $verification_warnings.length.should eql(1)
    $verification_warnings = []
    $verification_passes.should eql(4)
  end

  it 'Test 006 should give a warning when verifying the button element text is correct despite using a (NOT) verification' do
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new
    google_home.lucky_button.verify.not.text("I'm Feeling Lucky")
    google_home.lucky_button.verify.not.text("I'm not Feeling Lucky!")
    $verification_warnings.length.should eql(1)
    $verification_warnings = []
    $verification_passes.should eql(4)
  end

  it 'Test 007 should verify the button element is present' do
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new
    google_home.lucky_button.verify.present
    $verification_passes.should eql(2)
  end

  it 'Test 008 should verify an element not on the page is (NOT) present' do
    Driver.visit('http://www.google.com')
    Element.new('Random element', :css, '#no_id').verify.not.present
    $verification_passes.should eql(2)
  end

  it 'Test 009 should verify the button element is visible' do
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new
    google_home.lucky_button.verify.visible
    $verification_passes.should eql(2)
  end

  it 'Test 010 should verify an element not on the page is (NOT) visible' do
    Driver.visit('http://www.google.com')
    Element.new('Random element', :css, '#no_id').verify.not.visible
    $verification_passes.should eql(2)
  end

  it 'Test 011 should give a warning when verifying a button element is on the page when using a (NOT PRESENT) verification' do
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new
    google_home.lucky_button.verify.not.present
    google_home.lucky_button.verify.present
    $verification_warnings.length.should eql(1)
    $verification_warnings = []
    $verification_passes.should eql(2)
  end

  it 'Test 012 should give a warning when verifying a button element is on the page when using a (NOT VISIBLE) verification' do
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new
    google_home.lucky_button.verify.not.visible
    google_home.lucky_button.verify.visible
    $verification_warnings.length.should eql(1)
    $verification_warnings = []
    $verification_passes.should eql(2)
  end

  it 'Test 013 should give a warning when verifying a non-existent element is on the page using a (PRESENT) verification' do
    Driver.visit('http://www.google.com')
    Element.new('Random element', :css, '#no_id').verify.present
    Element.new('Random element', :xpath, '//*').verify.present
    $verification_warnings.length.should eql(1)
    $verification_warnings = []
    $verification_passes.should eql(2)
  end

  it 'Test 014 should give a warning when verifying a non-existent element is on the page using a (VISIBLE) verification' do
    Driver.visit('http://www.google.com')
    Element.new('Random element', :css, '#no_id').verify.visible
    Element.new('Random element', :xpath, '//*').verify.visible
    $verification_warnings.length.should eql(1)
    $verification_warnings = []
    $verification_passes.should eql(2)
  end

  it 'Test 015 should give an error when verifying a non-existent element is on the page using a (WAIT_UNTIL) verification' do
    Driver.visit('http://www.google.com')
    Log.info('The following error is anticipated.')
    expect {Element.new('Random element', :css, '#no_id').wait_until.visible}.to raise_error
  end

  it 'Test 016 should click on a page object element and confirm transition to new page object' do
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new
    google_home.gmail_option.click
    gmail_home = GmailHome.new
    gmail_home.nav_gmail_icon.wait_until.present
    $verification_passes.should eql(3)
  end

  it 'Test 017 should hover over an element and verify a new previously-hidden element' do
    Driver.visit('http://www.denverpost.com')
    Element.new('Tools', :xpath, "//a[@id='headerPrimaryToolsLink' and contains(.,'Tools')]").hover_over
    Element.new('Archives', :xpath, "//li[@id='headerSecondaryArchives']").wait_until.visible
    $verification_passes.should eql(3)
  end

end
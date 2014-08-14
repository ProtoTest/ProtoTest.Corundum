require 'spec_helper'

describe 'Corundum Driver extensions spec' do
  include_context 'corundum'

  it 'Test 001 should highlight elements on test execution' do
    $highlight_verifications = true
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new
    google_home.plus_you.verify.visible
    google_home.gmail_option.verify.visible
    google_home.images_option.verify.visible
    google_home.apps_option.verify.visible
    google_home.signin_button.verify.visible
    google_home.google_logo.verify.visible
    google_home.search_box.verify.visible
    google_home.search_button.verify.visible
    google_home.lucky_button.verify.visible
    $verification_passes.should eql(10)
  end

  it 'Test 002 should scroll an element into view' do
    Driver.visit('http://www.prototest.com')
    copyright_bar = Element.new('Copyright bar', :xpath, "//p[@class='copyright']")
    copyright_bar.scroll_into_view
    copyright_bar.verify.visible
    $verification_passes.should eql(3)
  end

end
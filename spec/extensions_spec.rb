require 'rspec'
require 'spec_helper'
require 'corundum_context'
require 'page_objects/google_home'

describe 'Driver extensions spec' do
  include_context 'corundum context'

  it 'Test 001 should highlight elements on test execution' do
    $log.info(example.description)
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
  end

end
require 'spec_helper'

describe 'Browser driver spec' do
  include_context 'corundum'

  test_url = "http://prototest.com"
  test_driver = Driver

  it 'Test 001 should launch browser and url (specified by spec config)' do
    site = test_url #pulls from test config (above)
    test_driver.visit(site) #Driver pulls from test config (above)
    test_driver.verify_url("prototest.com")
    test_driver.visit('http://www.google.com')
    $verification_passes.should eql(3)
  end

  it 'Test 002 should launch browser and url (specified by config class)' do
    site = Corundum.config.url #pulls from framework config
    Driver.visit(site) #Driver pulls from framework config
    Driver.verify_url("google.com")
    $verification_passes.should eql(2)
  end

  it 'Test 003 should launch browser and url (specified by spec helper)' do
    site = Corundum.config.url #pulls from spec_helper config
    Driver.visit(site) #Driver pulls from framework config
    Driver.verify_url("google.com")
    $verification_passes.should eql(2)
  end

  it 'Test 004 should raise an error when visiting a redirected website' do
    site = "http://goo.gl/k4fDoB" #redirects to prototest.com
    Driver.visit(site)
    Log.info('The following error is anticipated.')
    $verification_passes.should eql(1)
    expect{Driver.verify_url(site)}.to raise_error
  end

  it 'Test 005 should switch between next and main windows' do
    Driver.visit("http://accounts.google.com")
    Driver.verify_url("accounts.google.com")
    Element.new('Google Login panel', :xpath, "//div[@class='card signin-card clearfix']").verify.visible
    Element.new('ProtoTest Logo', :xpath, "//h1[@id='logo']//img").verify.not.visible
    Driver.open_new_window("http://prototest.com")
    Driver.switch_to_next_window
    Driver.verify_url("prototest.com")
    Element.new('Google Login panel', :xpath, "//div[@class='card signin-card clearfix']").verify.not.visible
    Element.new('ProtoTest Logo', :xpath, "//h1[@id='logo']//img").verify.visible
    Driver.switch_to_main_window
    Driver.verify_url("accounts.google.com")
  end

  it 'Test 006 should switch between opened windows' do
    Driver.visit("http://www.google.com")
    Driver.verify_url("google.com")
    Driver.open_new_window("http://wikipedia.org")
    Driver.switch_to_window("Wikipedia")
    Driver.verify_url("wikipedia.org")
    Driver.switch_to_window("Google")
    Driver.verify_url("google.com")
  end

  it 'Test 007 should list all open windows, then close one' do
    Driver.visit("http://www.google.com")
    Driver.open_new_window("http://wikipedia.org")
    Driver.open_new_window("http://www.prototest.com")
    Driver.list_open_windows
    Driver.driver.window_handles.length.should eql(3)
    Driver.switch_to_window("Wikipedia")
    Element.new('Wikipedia logo', :xpath, "//div[@class='central-featured-logo']").verify.visible
    Element.new('Google logo', :xpath, "//*[@id='hplogo']").verify.not.visible
    Driver.close_window
    Driver.list_open_windows
    Driver.switch_to_window("Google")
    Element.new('Wikipedia logo', :xpath, "//div[@class='central-featured-logo']").verify.not.visible
    Element.new('Google logo', :xpath, "//*[@id='hplogo']").verify.visible
    Driver.list_open_windows
    Driver.driver.window_handles.length.should eql(2)
  end

end
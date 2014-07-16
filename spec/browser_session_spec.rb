require 'rspec'
require 'spec_helper'

describe 'Browser session' do

  it 'should initialize a new browser session' do
    browser1 = Driver.new(:firefox)
    browser2 = BrowserSession.new(BrowserSession::FIREFOX)
    puts(browser1.browser_type)
    puts(browser2.browser_type)
  end

  it 'should launch browser specified from config file' do
    ENV['CONFIG_FILE'] ||= 'spec/config.yaml'
    config = CorundumConfig.new
    browser = Driver.for(config.browser.intern)
    browser.visit(config.url)
    sleep(3)
    browser.quit
  end

  it 'should launch firefox when browser_type is firefox and then click an element' do
    session = BrowserSession.new(BrowserSession::FIREFOX)
    session.launch
    session.open_url('http://www.google.com')
    sleep(5)
    input = session.driver.browser.find_element(:xpath, "//*[@id='gbqfq']")
    input.click
    input.send_keys('prototest')
    sleep(2)
    session.close
  end

end
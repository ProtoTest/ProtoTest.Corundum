require 'rspec'
require 'corundum'

describe 'Browser session' do

  it 'should initialize a new browser session' do
    browser1 = BrowserSession.new(BrowserSession::CHROME)
    browser2 = BrowserSession.new(BrowserSession::FIREFOX)
    puts(browser1.browser_type)
    puts(browser2.browser_type)
  end

  it 'should launch firefox when browser_type is firefox' do
    browser = BrowserSession.new(BrowserSession::FIREFOX)
    browser.launch
    browser.open_url('http://www.google.com')
    sleep(5)
    browser.close
  end

  it 'should launch browser specified from config file' do
    ENV['CONFIG_FILE'] ||= 'spec/config.yaml'
    config = CorundumConfig.new

    browser = BrowserSession.new(config.browsers[0]['browser'])
    browser.launch
    config.urls.each do | url |
      browser.open_url(url)
      sleep(3)
    end
    
    browser.close
  end

end
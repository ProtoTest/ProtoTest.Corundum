require 'corundum/selenium/driver'

class BrowserSession
  FIREFOX = :firefox
  CHROME = :chrome
  SAFARI = :safari
  INTERNET_EXPLORER = :ie
  ANDROID_DEFAULT = :android
  IPHONE_DEFAULT = :iphone
  IPAD_DEFAULT = :ipad

  attr_reader :browser_type, :driver

  def initialize(browser_type)
    @browser_type = browser_type
  end

  def launch
    @driver = Corundum::Selenium::Driver.new(:browsers => [{:browser => @browser_type}])
  end

  def open_url(url)
    @driver.visit(url)
  end

  def close
    @driver.quit
  end

end
require 'selenium-webdriver'

class BrowserSession
  FIREFOX = :firefox
  CHROME = :chrome
  SAFARI = :safari
  INTERNET_EXPLORER = :ie
  ANDROID_DEFAULT = :android
  IPHONE_DEFAULT = :iphone
  IPAD_DEFAULT = :ipad

  attr_reader :browser_type

  def initialize(browser_type)
    @browser_type = browser_type
  end

  def open(url)
    @driver = Selenium::WebDriver.for :firefox
    @driver.get(url)
  end

  def close
    @driver.quit
  end
end
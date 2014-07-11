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

  def launch
    @driver = Selenium::WebDriver.for :firefox
  end

  def open_url(url)
    @driver.get(url)
  end

  def close
    @driver.quit
  end
end
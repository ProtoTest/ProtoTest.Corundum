require 'selenium-webdriver'

module Corundum

  module_function
  def config; @config end
  def config= v; @config = v end
  module_function
  def session; @session end
  def session= v; @session = v end

  def element(locator_type, locator)
    @session.driver.browser.find_element(locator_type, locator)
  end

  def open_url(url)
    @session.open_url(url)
  end

end
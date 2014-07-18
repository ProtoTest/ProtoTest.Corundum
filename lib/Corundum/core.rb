require 'selenium-webdriver'

# Core class - allows reusable actions to be performed in the same instance of a single test

module Corundum

  @@config = nil
  @@session = nil

  def config
    @@config
  end

  def config= v
    @@config = v
  end

  def session
    @@session
  end

  def session= v
    @@session = v
  end

  def element(locator_type, locator)
    @@session.find_element(locator_type, locator)
  end

  def visit(url)
    @@session.visit(url)
  end

end


require 'selenium-webdriver'

# add human readable name for the element
class Selenium::WebDriver::Element
  attr_accessor :name
end

module Corundum
  module Selenium
  end
end

class Corundum::Selenium::Element

  def initialize(name, by, locator)
    @name = name
    @by = by
    @locator = locator
    @driver = Corundum::Selenium::Driver.driver
    @element = nil
  end

  def element
    if @element.nil? or is_stale?
      wait = Selenium::WebDriver::Wait.new
      wait.until {@element = @driver.find_element(@by, @locator); @element.displayed?}
    end

    @element
  end

  def element= e
    @element = e
  end

  def attribute(name)
    element.attribute(name)
  end

  def present?
    element.enabled?
  end

  def clear
    element.clear
  end

  def click
    element.click
  end

  def displayed?
    element.displayed?
  end

  def send_keys(*args)
    element.send_keys *args
  end

  def location
    element.location
  end

  def size
    element.size
  end

  def selected?
    element.selected?
  end

  def tag_name
    element.tag_name
  end

  def submit
    element.submit
  end

  def text
    element.text
  end

  def text= text
    element.clear
    element.send_keys text
  end

  #
  # Search for an element within this element
  #
  # @param [Symbol] by  (:css or :xpath)
  # @param [String] locator
  #
  # @return [Element] element
  #
  def find_element(by, locator)
    element.find_element(by, locator)
  end

  #
  # Search for an elements within this element
  #
  # @param [Symbol] by  (:css or :xpath)
  # @param [String] locator
  #
  # @return [Array] elements
  #
  def find_elements(by, locator)
    element.find_elements(by, locator)
  end

  def method_missing(method_sym, *arguments, &block)
    puts("called #{method_sym} on element #{@locator} by #{@by_type}")
    if @element.respond_to?(method_sym)
      @element.method(method_sym).call(*arguments, &block)
    else
      super
    end
  end

  private

  def is_stale?
    begin
      @element.enabled
      return false
    rescue Exception => e
      return true
    end
  end
end

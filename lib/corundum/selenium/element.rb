require 'selenium-webdriver'

# add human readable name for the element
class Selenium::WebDriver::Element
  attr_accessor :name
end

module Corundum
  module Selenium
  end
end

include Corundum


class Corundum::ElementVerification

  @@fail_base_str = "ELEMENT VERIFICATION ERROR::"
  @@pass_base_str = "ELEMENT VERIFICATION PASSED::"

  #
  # @param [Corundum::Selenium::Element] element
  # @param [Integer] timeout
  # @param [Boolean] is_true # TODO: Pick a better goddamn name
  def initialize(element, timeout, condition=true)
    @element = element
    @timeout = timeout
    @condition = condition

  end

  def not
    ElementVerification.new(@element, @timeout, false)
  end

  # TODO: Put the NOT verification string in the pass/fail string!å
  def text(text)
    element_text = @element.text

    test_result = @element.present? && element_text.eql?(text)
    if test_result == @condition
      puts ("#{@@pass_base_str} Verified element text '#{text}'")
    else
      raise "#{@@fail_base_str} Failed to verify element text condition '#{text}. Actual value is #{element_text}'"
    end
  end

  def visible

  end

  def present

  end

  def value(value)

  end

  def selected

  end

  def attribute(attribute, value)

  end

  def css(attribute, value)

  end


end

class Corundum::Selenium::Element

  def initialize(name, by, locator)
    @name = name
    @by = by
    @locator = locator

    # wrapped driver
    @driver = Corundum::Selenium::Driver.driver

    # selenium web element
    @element = nil
  end

  def element
    if @element.nil? or is_stale?
      wait = Selenium::WebDriver::Wait.new :timeout => Corundum::Config::ELEMENT_TIMEOUT
      wait.until {@element = @driver.find_element(@by, @locator); @element.enabled?}
    end

    @element
  end

  def element= e
    @element = e
  end

  def verify(timeout=0)
    timeout = Corundum::Config::ELEMENT_TIMEOUT if timeout.eql?(0)
    ElementVerification.new(self, timeout)
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

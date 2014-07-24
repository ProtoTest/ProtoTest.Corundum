require 'selenium-webdriver'

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
  # @param [Boolean] not_verification - Whether or not we are 'NOT' verifying something about the element
  #
  def initialize(element, timeout, not_verification=false)
    @element = element
    @timeout = timeout
    @not_verification = not_verification
  end

  def not
    ElementVerification.new(@element, @timeout, true)
  end

  def text(text)
    message = nil

    if @not_verification
      message = "does not contain text #{text}"
    else
      message = "contains text '#{text}'"
    end

    element_text = @element.text

    wait = Selenium::WebDriver::Wait.new :timeout => @timeout
    wait.until do
      condition = @element.present? && element_text.eql?(text)
      if condition != @not_verification
        log_success(message)
        return @element
      end
    end

    # Verification failure
    message += ". Actual: #{element_text}"
    log_error(message)

    @element
  end

  def visible
    message = nil

    if @not_verification
      message = "not visible"
    else
      message = "is visible"
    end

    wait = Selenium::WebDriver::Wait.new :timeout => @timeout
    wait.until do
      condition = @element.displayed?
      if condition != @not_verification
        log_success(message)
        return @element
      end
    end

    # Verification failure
    log_error(message)

    @element
  end

  def present
    message = nil

    if @not_verification
      message = "not present"
    else
      message = "is present"
    end

    wait = Selenium::WebDriver::Wait.new :timeout => @timeout
    wait.until do
      condition = @element.present?
      if condition != @not_verification
        log_success(message)
        return @element
      end
    end

    # Verification failure
    log_error(message)

    @element
  end

  # TODO:
  def value(value)
    raise NotImplementedError
  end

  # TODO:
  def selected
    raise NotImplementedError
  end

  # TODO:
  def attribute(attribute, value)
    raise NotImplementedError
  end

  # TODO:
  def css(attribute, value)
    raise NotImplementedError
  end


  private

  # TODO: add this to the list of verification errors that will be created at some point
  def log_error(message)
    raise "#{@@fail_base_str}#{@element.name}(#{@element.by}=>'#{@element.locator}'): #{message} after #{@timeout} seconds"
  end

  def log_success(message)
    puts "#{@@pass_base_str}#{@element.name}(#{@element.by}=>'#{@element.locator}'): #{message}"
  end

end

class Corundum::Selenium::Element
  attr_reader :name, :by, :locator

  def initialize(name, by, locator)
    @name = name
    @by = by
    @locator = locator

    # wrapped driver
    @driver = Corundum::Selenium::Driver.driver

    # selenium web element
    @element = nil
  end

  def to_s
    "'#{@name}' (By:#{@by} => '#{@locator}')"
  end

  def element
    if @element.nil? or is_stale?
      wait = Selenium::WebDriver::Wait.new :timeout => Corundum::Config::ELEMENT_TIMEOUT
      wait.until {@element = @driver.find_element(@by, @locator); puts "Finding #{self}"; @element.enabled?}
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
    begin
      return element.enabled?
    rescue Exception => e
      return false
    end
  end

  def displayed?
    begin
      return element.displayed?
    rescue Exception => e
      return false
    end
  end

  def clear
    element.clear
  end

  def click
    puts "Clicking on #{self}"
    element.click
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

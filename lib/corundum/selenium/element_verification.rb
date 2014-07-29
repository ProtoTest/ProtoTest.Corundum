require 'verification_error'

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
  def initialize(element, timeout, fail_test=false, not_verification=false)
    @element = element
    @timeout = timeout
    @not_verification = not_verification
    @fail_test = fail_test
  end

  def not
    ElementVerification.new(@element, @timeout, @fail_test, not_verification=true)
  end

  def text(text)
    message = nil

    if @not_verification
      message = "does not contain text '#{text}'"
    else
      message = "contains text '#{text}'"
    end

    element_text = @element.text

    wait = Selenium::WebDriver::Wait.new :timeout => @timeout, :interval => 1
    begin
      wait.until do
        condition = @element.present? && element_text.eql?(text)
        if condition != @not_verification
          log_success(message)
          return @element
        end
      end
    rescue
      # fall-through
    end

    # Verification failure
    message += ". Actual: '#{element_text}'"
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

    wait = Selenium::WebDriver::Wait.new :timeout => @timeout, :interval => 1
    begin
      wait.until do
        condition = @element.displayed?
        if condition != @not_verification
          log_success(message)
          return @element
        end
      end
    rescue
      # fall-through
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

    wait = Selenium::WebDriver::Wait.new :timeout => @timeout, :interval => 1
    begin
      wait.until do
        condition = @element.present?
        if condition != @not_verification
          log_success(message)
          return @element
        end
      end
    rescue
      # fall-through
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

  # TODO: store the verification errors global in some test_data container
  def log_error(message)
    error = "#{@@fail_base_str}#{@element.name}(#{@element.by}=>'#{@element.locator}'): #{message} after #{@timeout} seconds"
    $verification_errors << VerificationError.new(error, take_screenshot=true)
    if @fail_test
      fail(error)
    else
      puts error
    end
  end

  def log_success(message)
    puts "#{@@pass_base_str}#{@element.name}(#{@element.by}=>'#{@element.locator}'): #{message}"
  end

end

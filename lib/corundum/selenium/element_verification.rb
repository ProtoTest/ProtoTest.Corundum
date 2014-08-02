
module Corundum
  module Selenium
  end
end

include Corundum

class Corundum::ElementVerification

  #
  # @param [Corundum::Selenium::Element] element
  # @param [Integer] timeout
  # @param [Boolean] not_verification - Whether or not we are 'NOT' verifying something about the element
  #
  def initialize(element, timeout, fail_test=false, not_verification=false)
    @element = element # Corundum::Element
    @timeout = timeout
    @not_verification = not_verification
    @fail_test = fail_test
  end

  def not
    ElementVerification.new(@element, @timeout, @fail_test, not_verification=true)
  end

  def text(text)
    not_message = nil
    pass_message = nil

    if @not_verification
      not_message = "does not contain text (#{text})"
    else
      not_message = "Element should contain (#{text})"
      pass_message = "contains text (#{text})"
    end

    element_text = @element.text

    wait = Selenium::WebDriver::Wait.new :timeout => @timeout, :interval => 1
    begin
      wait.until do
        Log.debug("Confirming text (#{text}) is within element...")
        condition = @element.present? && element_text.eql?(text)
        if condition != @not_verification
          Corundum::DriverExtensions.highlight(@element) if Corundum::Config::HIGHLIGHT_VERIFICATIONS
          Log.debug("Verified: '#{@element.name}' (By:(#{@element.by} => '#{@element.locator}')) #{pass_message}.")
          return @element
        end
      end
    rescue
      # fall-through
    end

    # Verification failure
    log_issue("#{not_message}. Actual text is: (#{element_text}).")

    @element
  end

  def visible
    not_message = nil
    pass_message = nil

    if @not_verification
      not_message = "Element is not visible."
    else
      not_message = "Element should be visible."
      pass_message = "is visible"
    end

    wait = Selenium::WebDriver::Wait.new :timeout => @timeout, :interval => 1
    begin
      wait.until do
        condition = @element.displayed?
        if condition != @not_verification
          Corundum::DriverExtensions.highlight(@element) if Corundum::Config::HIGHLIGHT_VERIFICATIONS
          Log.debug("Verified: '#{@element.name}' (By:(#{@element.by} => '#{@element.locator}')) #{pass_message}.")
          return @element
        end
      end
    rescue
      # fall-through
    end

    # Verification failure
    log_issue(not_message)

    @element
  end

  def present
    pass_message = nil

    if @not_verification
      not_message = "Element is not present."
    else
      not_message = "Element should be present."
      pass_message = "is present"
    end

    wait = Selenium::WebDriver::Wait.new :timeout => @timeout, :interval => 1
    begin
      wait.until do
        condition = @element.present?
        if condition != @not_verification
          Corundum::DriverExtensions.highlight(@element) if Corundum::Config::HIGHLIGHT_VERIFICATIONS
          Log.debug("Verified: '#{@element.name}' (By:(#{@element.by} => '#{@element.locator}')) #{pass_message}.")
          return @element
        end
      end
    rescue
      # fall-through
    end

    # Verification failure
    log_issue(not_message)

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
  def log_issue(message)
    # error = "#{@@fail_base_str}#{@element.name}(#{@element.by}=>'#{@element.locator}'): #{message} after #{@timeout} seconds"
    # $verification_errors << VerificationError.new(error, take_screenshot=true)
    if @fail_test
      Log.fail(message)
    else
      Log.warning(message)
    end
  end

  def log_success(message)
    Log.debug("#{@@pass_base_str}#{@element.name}(#{@element.by}=>'#{@element.locator}'): #{message}")
  end

end

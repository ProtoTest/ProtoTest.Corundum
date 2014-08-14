# Element Verifications class provides the actual confirmation of elements within a web page
# Test formatting: element.verify.[NOT].[PRESENT]

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
  def initialize(element, timeout, fail_test=false, element_should_exist=true)
    @element = element # Corundum::Element
    @timeout = timeout
    @should_exist = element_should_exist
    @fail_test = fail_test
  end

  def not
    ElementVerification.new(@element, @timeout, @fail_test, element_should_exist=false)
  end

  def text(text)
    fail_message = nil
    pass_message = nil
    should_have_text = @should_exist
    element_text = @element.text
    if @element.present?
      $verification_passes += 1
    else
      Log.error("Cannot determine element text.  Element is not present.")
    end

    if should_have_text
      fail_message = "Element should contain text (#{text}), but does not."
      pass_message = "contains text (#{text})."
    else
      fail_message = "Element should not contain text (#{text}), but does."
      pass_message = "does not contain text (#{text}).  Actual text is: (#{element_text})."
    end

    wait = Selenium::WebDriver::Wait.new :timeout => @timeout, :interval => 1
    begin
      wait.until do
        element_contains_text = element_text.eql?(text)
        if should_have_text && element_contains_text
          Log.debug("Confirming text (#{text}) is within element...")
          Corundum::ElementExtensions.highlight(@element) if Corundum::Config::HIGHLIGHT_VERIFICATIONS
          log_success(pass_message)
        elsif !should_have_text && !element_contains_text
          Log.debug("Confirming text (#{text}) is NOT within element...")
          Corundum::ElementExtensions.highlight(@element) if Corundum::Config::HIGHLIGHT_VERIFICATIONS
          log_success(pass_message)
        else
          log_issue("#{fail_message}  Element's text is: (#{element_text}).")
        end
      end
      @element
    end
  end

  def visible
    fail_message = nil
    pass_message = nil
    should_be_visible = @should_exist

    if should_be_visible
      fail_message = "Element should be visible."
      pass_message = "Element is visible."
    else
      fail_message = "Element should not be visible."
      pass_message = "Element is not visible."
    end

    wait = Selenium::WebDriver::Wait.new :timeout => @timeout, :interval => 1
    begin
      wait.until do
        element_is_displayed = @element.displayed?
        if element_is_displayed && should_be_visible
          Corundum::ElementExtensions.highlight(@element) if Corundum::Config::HIGHLIGHT_VERIFICATIONS
          log_success(pass_message)
          return @element
        elsif !element_is_displayed && !should_be_visible
          Log.debug("Confirming element is NOT visible...")
          log_success(pass_message)
        else
          log_issue(fail_message)
        end
      end
      @element
    end
  end

  def present
    fail_message = nil
    pass_message = nil
    should_be_present = @should_exist

    if should_be_present
      fail_message = "Element should be present."
      pass_message = "is present."
    else
      fail_message = "Element should NOT present."
      pass_message = "is not present."
    end

    wait = Selenium::WebDriver::Wait.new :timeout => @timeout, :interval => 1
    begin
      wait.until do
        element_is_present = @element.present?
        if element_is_present && should_be_present
          Corundum::ElementExtensions.highlight(@element) if Corundum::Config::HIGHLIGHT_VERIFICATIONS
          log_success(pass_message)
          return @element
        elsif !element_is_present && !should_be_present
          Log.debug("Confirming element is NOT present...")
          log_success(pass_message)
        else
          log_issue(fail_message)
        end
      end
      @element
    end
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
      Log.error("#{message} ['#{@element.name}' (By:(#{@element.by} => '#{@element.locator}'))].")
    else
      Log.warn("#{message} ['#{@element.name}' (By:(#{@element.by} => '#{@element.locator}'))].")
    end
  end

  def log_success(pass_message)
    $verification_passes += 1
    Log.debug("Verified: '#{@element.name}' (By:(#{@element.by} => '#{@element.locator}')) #{pass_message}")
  end

end

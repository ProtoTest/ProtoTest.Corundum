#require 'uri'
require 'selenium-webdriver'
require 'corundum/selenium/element'

module Corundum
  module Selenium
  end
end

class Corundum::Selenium::Driver < Selenium::WebDriver::Driver #Inherits from Base in case non-selenium driver is desired
  def find_element(*args)
    Element.new(super(*args), *args)
  end

  def visit(path)
    navigate.to(path)
  end

  def go_back
    navigate.back
  end

  def go_forward
    navigate.forward
  end

  def html
    page_source
  end

  def title
    title
  end

  def current_url
    current_url
  end

  def execute_script(script)
    execute_script script
  end

  def evaluate_script(script)
    execute_script "return #{script}"
  end

  def save_screenshot(path, options={})
    save_screenshot(path)
  end

  def reset!
    # Use instance variable directly so we avoid starting the browser just to reset the session
    begin
      begin
        manage.delete_all_cookies
      rescue Selenium::WebDriver::Error::UnhandledError
        # delete_all_cookies fails when we've previously gone
        # to about:blank, so we rescue this error and do nothing
        # instead.
      end
      navigate.to("about:blank")
    rescue Selenium::WebDriver::Error::UnhandledAlertError
      # This error is thrown if an unhandled alert is on the page
      # Firefox appears to automatically dismiss this alert, chrome does not
      # We'll try to accept it
      begin
        switch_to.alert.accept
      rescue Selenium::WebDriver::Error::NoAlertPresentError
        # The alert is now gone - nothing to do
      end
      # try cleaning up the browser again
      retry
    end

  end

  ##
  #
  # Webdriver supports frame name, id, index(zero-based) or {Capybara::Element} to find iframe
  #
  # @overload within_frame(index)
  # @param [Integer] index index of a frame
  # @overload within_frame(name_or_id)
  # @param [String] name_or_id name or id of a frame
  # @overload within_frame(element)
  # @param [Capybara::Node::Base] a_node frame element
  #
  # def within_frame(frame_handle)
  #   @frame_handles[window_handle] ||= []
  #   frame_handle = frame_handle.native if frame_handle.is_a?(Capybara::Node::Base)
  #   @frame_handles[window_handle] << frame_handle
  #   a=switch_to.frame(frame_handle)
  #   yield
  # ensure
  #   # There doesnt appear to be any way in Webdriver to move back to a parent frame
  #   # other than going back to the root and then reiterating down
  #   @frame_handles[window_handle].pop
  #   switch_to.default_content
  #   @frame_handles[window_handle].each { |fh| switch_to.frame(fh) }
  # end

  # def current_window_handle
  #   window_handle
  # end
  #
  # def window_size(handle)
  #   within_given_window(handle) do
  #     size = manage.window.size
  #     [size.width, size.height]
  #   end
  # end
  #
  # def resize_window_to(handle, width, height)
  #   within_given_window(handle) do
  #     manage.window.resize_to(width, height)
  #   end
  # end
  #
  # def maximize_window(handle)
  #   within_given_window(handle) do
  #     manage.window.maximize
  #   end
  #   sleep 0.1 # work around for https://code.google.com/p/selenium/issues/detail?id=7405
  # end
  #
  # def close_window(handle)
  #   within_given_window(handle) do
  #     close
  #   end
  # end
  #
  # def window_handles
  #   window_handles
  # end
  #
  # def open_new_window
  #   execute_script('window.open();')
  # end
  #
  # def switch_to_window(handle)
  #   switch_to.window handle
  # end
  #
  # # @api private
  # def find_window(locator)
  #   handles = window_handles
  #   return locator if handles.include? locator
  #
  #   original_handle = window_handle
  #   handles.each do |handle|
  #     switch_to_window(handle)
  #     if (locator == execute_script("return window.name") ||
  #         title.include?(locator) ||
  #         current_url.include?(locator))
  #       switch_to_window(original_handle)
  #       return handle
  #     end
  #   end
  #   raise "Could not find a window identified by #{locator}"
  # end
  #
  # def within_window(locator)
  #   handle = find_window(locator)
  #   switch_to.window(handle) { yield }
  # end

  #  def invalid_element_errors
  #    [Selenium::WebDriver::Error::StaleElementReferenceError, Selenium::WebDriver::Error::UnhandledError, Selenium::WebDriver::Error::ElementNotVisibleError]
  #  end
  #
  #  def no_such_window_error
  #    Selenium::WebDriver::Error::NoSuchWindowError
  #  end
  #
  # private
  #
  #  def within_given_window(handle)
  #    original_handle = self.current_window_handle
  #    if handle == original_handle
  #      yield
  #    else
  #      switch_to_window(handle)
  #      result = yield
  #      switch_to_window(original_handle)
  #      result
  #    end
  #  end
end
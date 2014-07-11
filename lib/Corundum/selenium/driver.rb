require 'uri'

class Corundum::Selenium::Driver < Corundum::Driver::Base
  attr_reader :driver

  DEFAULT_OPTIONS = {:browsers => [{ :browser => :firefox }]}

  def browser
    unless @browser
      main = Process.pid
      at_exit do
        # Store the exit status of the test run since it goes away after calling the at_exit proc...
        @exit_status = $!.status if $!.is_a?(SystemExit)
        quit if Process.pid == main
        exit @exit_status if @exit_status # Force exit with stored status
      end
    end

    return @browser
  end

  def initialize(options={})
    begin
      require 'selenium-webdriver'
    rescue LoadError => e
      if e.message =~ /selenium-webdriver/
        raise LoadError, "Capybara's selenium driver is unable to load `selenium-webdriver`, please install the gem and add `gem 'selenium-webdriver'` to your Gemfile if you are using bundler."
      else
        raise e
      end
    end

    @browser = nil
    @exit_status = nil
    @frame_handles = {}
    @options = DEFAULT_OPTIONS.merge(options)
  end

 def visit(path)
   browser.navigate.to(path)
 end

 def go_back
   browser.navigate.back
 end

 def go_forward
   browser.navigate.forward
 end

 def html
   browser.page_source
 end

 def title
   browser.title
 end

 def current_url
   browser.current_url
 end

 def execute_script(script)
   browser.execute_script script
 end

 def evaluate_script(script)
   browser.execute_script "return #{script}"
 end

 def save_screenshot(path, options={})
   browser.save_screenshot(path)
 end

 def reset!
   # Use instance variable directly so we avoid starting the browser just to reset the session
   if @browser
     begin
       begin @browser.manage.delete_all_cookies
       rescue Selenium::WebDriver::Error::UnhandledError
         # delete_all_cookies fails when we've previously gone
         # to about:blank, so we rescue this error and do nothing
         # instead.
       end
       @browser.navigate.to("about:blank")
     rescue Selenium::WebDriver::Error::UnhandledAlertError
       # This error is thrown if an unhandled alert is on the page
       # Firefox appears to automatically dismiss this alert, chrome does not
       # We'll try to accept it
       begin
         @browser.switch_to.alert.accept
       rescue Selenium::WebDriver::Error::NoAlertPresentError
         # The alert is now gone - nothing to do
       end
       # try cleaning up the browser again
       retry
     end
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
 def within_frame(frame_handle)
   @frame_handles[browser.window_handle] ||= []
   frame_handle = frame_handle.native if frame_handle.is_a?(Capybara::Node::Base)
   @frame_handles[browser.window_handle] << frame_handle
   a=browser.switch_to.frame(frame_handle)
   yield
 ensure
   # There doesnt appear to be any way in Webdriver to move back to a parent frame
   # other than going back to the root and then reiterating down
   @frame_handles[browser.window_handle].pop
   browser.switch_to.default_content
   @frame_handles[browser.window_handle].each { |fh| browser.switch_to.frame(fh) }
 end

 def current_window_handle
   browser.window_handle
 end

 def window_size(handle)
   within_given_window(handle) do
     size = browser.manage.window.size
     [size.width, size.height]
   end
 end

 def resize_window_to(handle, width, height)
   within_given_window(handle) do
     browser.manage.window.resize_to(width, height)
   end
 end

 def maximize_window(handle)
   within_given_window(handle) do
     browser.manage.window.maximize
   end
   sleep 0.1 # work around for https://code.google.com/p/selenium/issues/detail?id=7405
 end

 def close_window(handle)
   within_given_window(handle) do
     browser.close
   end
 end

 def window_handles
   browser.window_handles
 end

 def open_new_window
   browser.execute_script('window.open();')
 end

 def switch_to_window(handle)
   browser.switch_to.window handle
 end

 # @api private
 def find_window(locator)
   handles = browser.window_handles
   return locator if handles.include? locator

   original_handle = browser.window_handle
   handles.each do |handle|
     switch_to_window(handle)
     if (locator == browser.execute_script("return window.name") ||
         browser.title.include?(locator) ||
         browser.current_url.include?(locator))
       switch_to_window(original_handle)
       return handle
     end
   end
   raise "Could not find a window identified by #{locator}"
 end

 def within_window(locator)
   handle = find_window(locator)
   browser.switch_to.window(handle) { yield }
 end

 def quit
   @browser.quit if @browser
 rescue Errno::ECONNREFUSED
   # Browser must have already gone
 ensure
   @browser = nil
 end

 def invalid_element_errors
   [Selenium::WebDriver::Error::StaleElementReferenceError, Selenium::WebDriver::Error::UnhandledError, Selenium::WebDriver::Error::ElementNotVisibleError]
 end

 def no_such_window_error
   Selenium::WebDriver::Error::NoSuchWindowError
 end

private

 def within_given_window(handle)
   original_handle = self.current_window_handle
   if handle == original_handle
     yield
   else
     switch_to_window(handle)
     result = yield
     switch_to_window(original_handle)
     result
   end
 end
end
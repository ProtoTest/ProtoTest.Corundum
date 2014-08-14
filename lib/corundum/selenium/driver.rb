# Driver class wraps around the Selenium Webdriver driver, slightly expanding functionality in some areas
# Test formatting: [DRIVER].[VISIT](url)

require 'selenium-webdriver'
require 'uri'

module Corundum
  module Selenium
  end
end

class Corundum::Selenium::Driver
  @@driver = nil

  def self.reset
    driver.manage.delete_all_cookies
    driver.manage.timeouts.page_load = Corundum::Config::PAGE_TIMEOUT
    driver.manage.timeouts.implicit_wait = Corundum::Config::ELEMENT_TIMEOUT

    # Ensure the browser is maximized to maximize visibility of element
    # Currently doesn't work with chromedriver, but the following workaround does:
    if @browser_type.eql?(:chrome)
      width = driver.execute_script("return screen.width;")
      height = driver.execute_script("return screen.height;")
      driver.manage.window.move_to(0, 0)
      driver.manage.window.resize_to(width, height)
    else
      driver.manage.window.maximize
    end
  end

  def self.driver
    begin
      unless @@driver
        @browser_type = Corundum::Config::BROWSER
        if $target_ip && (!$target_ip.eql?('localhost'))
          @@driver = Selenium::WebDriver.for(:remote, :url => "http://#{$target_ip}:4444/wd/hub", :desired_capabilities => Corundum::Config::BROWSER)
        else
          @@driver = Selenium::WebDriver.for(Corundum::Config::BROWSER)
        end
        reset
      end
    rescue Exception => e
      Log.debug(e.backtrace.inspect)
      Log.error("Driver did not load within (#{Corundum::Config::PAGE_TIMEOUT}) seconds.  [#{e.message}]")
    end
    @@driver
  end

  def self.driver= driver
    @@driver.quit if @@driver
    @@driver = driver
  end

# =============== #
# Driver Commands #
# =============== #

  def self.visit(path)
    begin
      Log.debug("Navigating to url: (#{path}).")
      driver
      time_start = Time.now
      driver.navigate.to(path)
      time_end = Time.new
      page_load = (time_end - time_start)
      Log.debug("Page loaded in (#{page_load}) seconds.")
      $verification_passes += 1
    rescue Exception => e
      Log.debug(e.backtrace.inspect)
      Log.error("#{e.message} - Also be sure to check the url formatting.  http:// is required for proper test execution (www is optional).")
    end
  end

  def self.quit
    if @@driver
      Log.debug('Shutting down web driver...')
      @@driver.quit
      @@driver = nil
    end
  end

  def self.go_back
    driver.navigate.back
  end

  def self.go_forward
    driver.navigate.forward
  end

  def self.html
    driver.page_source
  end

  def self.title
    driver.title
  end

  def self.current_url
    driver.current_url
  end

  def self.current_domain
    site_url = driver.current_url.to_s
    # domain = site_url.match(/(https?:\/\/)?(\S*\.)?([\w\d]*\.\w+)\/?/i)[3]
    domain = URI.parse(site_url)
    host = domain.host
    if (!host.nil?)
      Log.debug("Current domain is: (#{host}).")
      return host
    else
      Log.error("Unable to parse URL.")
    end
  end

  def self.verify_url(url)
    Log.debug('Verifying URL...')
    domain = self.current_domain.to_s
    if url.include?(domain)
      Log.debug("Confirmed. (#{url}) includes (#{domain}).")
      $verification_passes += 1
    else
      Log.error("(#{url}) does not include (#{domain}).")
    end
  end

  def self.execute_script(script, element)
    driver.execute_script(script, element)
  end

  def self.execute_script_driver(script)
    driver.execute_script(script)
  end

  def self.evaluate_script(script)
    driver.execute_script "return #{script}"
  end

  def self.save_screenshot
    Log.debug ("Capturing screenshot of browser...")
    timestamp = Time.now.strftime("%Y_%m_%d__%H_%M_%S")
    screenshot_path = File.join($current_run_dir, "screenshot__#{timestamp}.png")
    driver.save_screenshot(screenshot_path)
    $screenshots_captured.push("screenshot__#{timestamp}.png") # used by custom_formatter.rb for embedding in report
    $fail_screenshot = "screenshot__#{timestamp}.png"
  end

  def self.list_open_windows
    handles = driver.window_handles
    Log.debug("List of active windows:")
    handles.each do |handle|
      driver.switch_to.window(handle)
      Log.debug("|  Window with title: (#{driver.title}) and handle: #{handle} is currently open.")
    end
    driver.switch_to.window(driver.window_handles.first)
  end

  def self.open_new_window(url)
    Log.debug("Opening new window and loading url (#{url})...")
    DriverExtensions.open_new_window(url)
  end

  def self.close_window
    Log.debug("Closing window (#{driver.title})...")
    DriverExtensions.close_window
  end

  def self.switch_to_window(title)
    driver.switch_to.window(driver.window_handles.first)
    current_title = driver.title
    Log.debug("Current window is: (#{current_title}).  Switching to next window (#{title})...")
    handles = driver.window_handles
      handles.each do |handle|
        if driver.title == title
          Log.debug("Window (#{driver.title}) is now the active window.")
          return
        end
        driver.switch_to.window(handle)
      end
    list_open_windows
    Log.error("Unable to switch to window with title #{title}.")
  end

  def self.switch_to_next_window
    current_title = driver.title
    Log.debug("Current window is: (#{current_title}).  Switching to next window...")
    driver.switch_to.window(driver.window_handles.last)
    Log.debug("Window (#{driver.title}) is now the active window.")
  end

  def self.switch_to_main_window
    current_title = driver.title
    Log.debug("Current window is: (#{current_title}).  Switching to main window...")
    driver.switch_to.window(driver.window_handles.first)
    Log.debug("Window (#{driver.title}) is now the active window.")
  end

end



### Handy Capybara methods that could be duplicated

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
# Element class wraps around the Selenium driver's element (driver.find_element) functionality
# Test formatting: [ELEMENT].[VERIFY].not.present

require 'selenium-webdriver'
require 'corundum/selenium/element_verification'
require 'oily_png'

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
      wait = Selenium::WebDriver::Wait.new :timeout => Corundum::Config::ELEMENT_TIMEOUT, :interval => 1
      wait.until {@element = @driver.find_element(@by, @locator); Log.debug("Finding element #{self}..."); @element.enabled?}
    end
    @element
  end

  def element= e
    @element = e
  end

  # ================ #
  # Element Commands #
  # ================ #

  # soft failure, will not kill test immediately
  def verify(timeout=nil)
    Log.debug('Verifying element...')
    timeout = Corundum::Config::ELEMENT_TIMEOUT if timeout.nil?
    ElementVerification.new(self, timeout)
  end

  # hard failure, will kill test immediately
  def wait_until(timeout=nil)
    Log.debug('Waiting for element...')
    timeout = Corundum::Config::ELEMENT_TIMEOUT if timeout.nil?
    ElementVerification.new(self, timeout, fail_test=true)
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
    Log.debug("Clicking on #{self}")
    ElementExtensions.highlight(self) if Corundum::Config::HIGHLIGHT_VERIFICATIONS
    element.click
  end

  def send_keys(*args)
    Log.debug("Typing: #{args} into element: (#{self}).")
    ElementExtensions.highlight(self) if Corundum::Config::HIGHLIGHT_VERIFICATIONS
    element.send_keys *args
  end

  def location
    element.location
  end

  def scroll_into_view
    self.verify.present
    ElementExtensions.scroll_to(self)
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
    Log.debug('Finding element...')
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

  def save_element_screenshot
    Log.debug ("Capturing screenshot of element...")
    self.scroll_into_view

    timestamp = Time.now.strftime("%Y_%m_%d__%H_%M_%S")
    name = self.name.gsub(' ', '_')
    screenshot_path = File.join($current_run_dir, "#{name}__#{timestamp}.png")
    @driver.save_screenshot(screenshot_path)

    location_x = self.location.x
    location_y = self.location.y
    element_width = self.size.width
    element_height = self.size.height

    # ChunkyPNG commands tap into oily_png (performance-enhanced version of chunky_png)
    image = ChunkyPNG::Image.from_file(screenshot_path.to_s)
    image1 = image.crop(location_x, location_y, element_width, element_height)
    image2 = image1.to_image
    image2.save(File.join($current_run_dir, "#{name}__#{timestamp}.png"))
  end

  def method_missing(method_sym, *arguments, &block)
    Log.debug("called #{method_sym} on element #{@locator} by #{@by_type}")
    if @element.respond_to?(method_sym)
      @element.method(method_sym).call(*arguments, &block)
    else
      super
    end
  end

  private

  def is_stale?
    begin
      @element.enabled?
      return false
    rescue Exception => e
      return true
    end
  end
end

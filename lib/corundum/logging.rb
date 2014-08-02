require 'rspec'
require 'logger'
require 'chunky_png'

# Logging class - allows for display and recording of diagnostic information

class Logging

# #    logger.level = Logger::WARN
#
# def initialize
#     $log_file = File.open(ARGV[3], File::WRONLY | File::APPEND | File::CREAT)
#     $logger.attach($log_file)
#
#   logger.level = CorundumConfig.
#   logger.datetime_format = '%Y-%m-%d %H:%M:%S'
#   logger.formatter = proc do |datetime, msg|
#     "<#{datetime}>: #{msg}\n"
#   end
# end

  @@time_format = "[%Y-%m-%d %H:%M:%S]"
  @@screenshot_path = nil

  def debug(text)
    timestamp = Time.now.strftime(@@time_format)
    #Logger.add(text)
    puts ("#{timestamp} --> #{text}")
  end

  def info(text)
    timestamp = Time.now.strftime(@@time_format)
    #Logger.info(text)
    puts ("#{timestamp}     #{text}")
  end

  def warning(text)
    timestamp = Time.now.strftime(@@time_format)
    #Logger.warn(text)
    puts ("#{timestamp} [W] #{text}")
    # capture_screenshot
    warn("\nWARNING: #{text}")
  end

  def error(text)
    timestamp = Time.now.strftime(@@time_format)
    #Logger.error(text)
    puts ("#{timestamp} [E] #{text}")
    capture_screenshot
    fail("ERROR: #{text}")
  end

  def message(text)
    timestamp = Time.now.strftime(@@time_format)
    #Logger.message(text)
    puts ("#{timestamp} --- #{text}")
  end

  def capture_screenshot
    debug ("Capturing screenshot of browser...")
    timestamp = Time.now.strftime("%Y_%m_%d__%H_%M_%S")
    screenshot_path = File.join(REPORT_DIR, "#{timestamp}.png")
    Driver.save_screenshot(screenshot_path)
  end

  def capture_element(element)
    debug ("Capturing screenshot of element...")
    element.scroll_into_view

    timestamp = Time.now.strftime("%Y_%m_%d__%H_%M_%S")
    name = element.name.gsub(' ', '_')
    screenshot_path = File.join(REPORT_DIR, "#{name}__#{timestamp}.png")
    Driver.save_screenshot(screenshot_path)

    location_x = element.location.x
    location_y = element.location.y
    element_width = element.size.width
    element_height = element.size.height

    image = ChunkyPNG::Image.from_file(screenshot_path.to_s)
    image1 = image.crop(location_x, location_y, element_width, element_height)
    image2 = image1.to_image
    image2.save("#{REPORT_DIR}\\#{name}__#{timestamp}.png")
  end

end

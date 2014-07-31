require 'rspec'
require 'logger'

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
      debug ("Capturing screenshot...")
      timestamp = Time.now.strftime("%Y-%m-%d %H_%M_%S")
      screenshot_path = File.join(REPORT_DIR, "#{timestamp}.png")
      Driver.save_screenshot(screenshot_path)
    end

    # def capture_element
    #   debug ("Capturing screenshot of element only...")
    #   timestamp = Time.now.strftime("%Y-%m-%d %H_%M_%S")
    #   screenshot_path = File.join(REPORT_DIR, "#{timestamp}.png")
    #   Driver.save_screenshot(screenshot_path)
    # end
end

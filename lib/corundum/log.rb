require 'rspec'
require 'logger'

# Logging class - allows for display and recording of diagnostic information

class Log

# #    logger.level = Logger::WARN
#
# def initialize
#     Log_file = File.open(ARGV[3], File::WRONLY | File::APPEND | File::CREAT)
#     Logger.attach(Log_file)
#
#   logger.level = CorundumConfig.
#   logger.datetime_format = '%Y-%m-%d %H:%M:%S'
#   logger.formatter = proc do |datetime, msg|
#     "<#{datetime}>: #{msg}\n"
#   end
# end

  @@time_format = "[%Y-%m-%d %H:%M:%S]"
  @@screenshot_path = nil

  def self.debug(text)
    timestamp = Time.now.strftime(@@time_format)
    #Logger.add(text)
    puts ("#{timestamp} --> #{text}")
  end

  def self.info(text)
    timestamp = Time.now.strftime(@@time_format)
    #Logger.info(text)
    puts ("#{timestamp}     #{text}")
  end

  def self.warning(text)
    timestamp = Time.now.strftime(@@time_format)
    #Logger.warn(text)
    puts ("#{timestamp} [W] #{text}")
    # capture_screenshot
    warn("\nWARNING: #{text}")
  end

  def self.error(text)
    timestamp = Time.now.strftime(@@time_format)
    #Logger.error(text)
    puts ("#{timestamp} [E] #{text}")
    capture_screenshot
    fail("ERROR: #{text}")
  end

  def self.message(text)
    timestamp = Time.now.strftime(@@time_format)
    #Logger.message(text)
    puts ("#{timestamp} --- #{text}")
  end

end

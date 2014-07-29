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

    def debug(text)
      timestamp = Time.now.strftime(@@time_format)
      #Logger.add(text)
      puts ("#{timestamp} >>> #{text}")
    end

    def info(text)
      timestamp = Time.now.strftime(@@time_format)
      #Logger.info(text)
      puts ("#{timestamp}     #{text}")
    end

    def warn(text)
      timestamp = Time.now.strftime(@@time_format)
      #Logger.warn(text)
      puts ("#{timestamp} [W] #{text}")
    end

    def error(text)
      timestamp = Time.now.strftime(@@time_format)
      #Logger.error(text)
      puts ("#{timestamp} [E] #{text}")
    end

end

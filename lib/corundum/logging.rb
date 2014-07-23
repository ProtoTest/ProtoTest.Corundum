# require 'logger'
#
# # Logging class - allows for display and recording of diagnostic information
#
# class Logging
#   include Corundum
#
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
#
#   def debug(text)
#     Logger.log(text)
#     #logger.debug(text)
#     #puts ("#{timestamp} --> #{text}")
#   end
#
#   def info(text)
#     timestamp = Time.now.strftime("[%Y-%m-%d %H:%M:%S]")
#     puts ("#{timestamp}     #{text}")
#   end
#
#   def error(text)
#     timestamp = Time.now.strftime("[%Y-%m-%d %H:%M:%S]")
#     puts ("#{timestamp} [X] #{text}")
#   end
#
# end
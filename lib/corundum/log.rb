# Logger class wraps around ruby 'logger' gem to provide diagnostic and workflow information

require 'logger'

# Add in multiple device logging directly into Logger class
class Logger
  # Creates or opens a secondary log file.
  def attach(name)
    @logdev.attach(name)
  end

  # Closes a secondary log file.
  def detach(name)
    @logdev.detach(name)
  end

  class LogDevice # :nodoc:
    attr_reader :devs

    def attach(log)
      @devs ||= {}
      @devs[log] = open_logfile(log)
    end

    def detach(log)
      @devs ||= {}
      @devs[log].close
      @devs.delete(log)
    end

    alias_method :old_write, :write
    def write(message)
      old_write(message)

      @devs ||= {}
      @devs.each do |log, dev|
        dev.write(message)
      end
    end
  end
end # class logger



# Singleton Logger class

class Corundum::Log
  @@logger = nil

#
# more generic than INFO, useful for debugging issues
# DEBUG = 0
# generic, useful information about system operation
# INFO = 1
# a warning
# WARN = 2
# a handleable error condition
# ERROR = 3
# an unhandleable error that results in a program crash
# FATAL = 4
# an unknown message that should always be logged
# UNKNOWN = 5

  def self.error msg
    log.error msg
  end

  def self.warn msg
    log.warn msg
  end

  def self.info msg
    log.info msg
  end

  def self.debug msg
    log.debug msg
  end

  def self.add_device device
    @@devices ||= []
    unless @@logger
      initialize_logger
    end
    @@logger.attach(device)
    @@devices << device
  end

  def self.close
    @@devices.each {|dev| @@logger.detach(dev)}
    @@devices.clear
    @@logger.close if @@logger
  end

  private

  def self.log
    unless @@logger
      initialize_logger
    end
    @@logger
  end

  def self.initialize_logger
    unless @@logger
      # log to STDOUT and file
      @@logger = Logger.new(STDOUT)

      # messages that have the set level or higher will be logged
      case Corundum::Config::LOG_LEVEL
        when :debug then level = Logger::DEBUG
        when :info then level = Logger::INFO
        when :warn then level = Logger::WARN
        when :error then level = Logger::ERROR
        when :fatal then level = Logger::FATAL
      end

      @@logger.level = level

      @@logger.formatter = proc do |severity, datetime, progname, msg|
        sev = severity.to_s
        if sev.eql?("DEBUG")
          "[#{datetime.strftime('%Y-%m-%d %H:%M:%S')}][#{severity}]   #{msg}\n"
        elsif sev.eql?("INFO")
          "[#{datetime.strftime('%Y-%m-%d %H:%M:%S')}][#{severity}]  > #{msg}\n"
        elsif sev.eql?("WARN")
          "[#{datetime.strftime('%Y-%m-%d %H:%M:%S')}][#{severity}]  - #{msg}\n"
        else
          "[#{datetime.strftime('%Y-%m-%d %H:%M:%S')}][#{severity}] - #{msg}\n"
        end
      end
    end
  end
end # Log class
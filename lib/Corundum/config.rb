require 'yaml'

# Configuration class - reads from config file at CONFIG_FILE environment variable location (declared in tests)

class CorundumConfig

  attr_reader :config_file, :browser, :url, :log_level #, :screenshot_on_error

  def initialize
    @config_file = ENV['CONFIG_FILE']
    if config_file.nil?
      @config_file = 'spec/config.yaml'
    end
    @config = YAML.load_file(@config_file)

    @browser = config_or_default('browser', :firefox)
    @url = config_or_default('url', [:url => 'http://www.prototest.com'])
    @log_level = config_or_default('log_level', [:log_level => 'DEBUG'])
    #@screenshot_on_error = config_or_default('@screenshot_on_error', true)
  end

  def config_or_default(config_key, default)
    if @config.has_key? config_key
      @config[config_key]
    elsif ENV.has_key? config_key.upcase
      ENV[config_key.upcase]
    else
      default
    end
  end

end
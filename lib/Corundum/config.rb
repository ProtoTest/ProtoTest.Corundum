require 'yaml'

# Config class - reads from config file at CONFIG_FILE environment variable location

class Config

  CONFIG_FILE = ENV['CONFIG_FILE']
  attr_reader browsers, screenshot_on_error

  def initialize
    @config = YAML.load_file(CONFIG_FILE)
    @browsers = config_or_default('browsers', [{:browser => :firefox}])
    @screenshot_on_error = config_or_default('@screenhot_on_error', true)
  end

  def config_or_default(config_key, default)
    if @config.has_key? config_key
      @config['config_key']
    else
      default
    end
  end

end
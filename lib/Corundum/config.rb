require 'yaml'

# Config class - reads from config file at CONFIG_FILE environment variable location

class CorundumConfig

  attr_reader :config_file, :browsers, :screenshot_on_error

  def initialize
    @config_file = ENV['CONFIG_FILE']

    @config = YAML.load_file(@config_file)
    @browsers = config_or_default('browsers', [{:browser => :firefox}])
    @screenshot_on_error = config_or_default('@screenhot_on_error', true)
  end

  def config_or_default(config_key, default)
    if @config.has_key? config_key
      @config[config_key]
    else
      default
    end
  end

end
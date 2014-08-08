# Config class provides configuration hooks for tests to control aspects of runtime settings

module Corundum
  module Config
    REPORTS_OUTPUT = $reports_output || Dir.home
    TARGET_IP = $target_ip || 'localhost'
    BROWSER = $browser || :firefox
    URL = $url || 'www.google.com'
    PAGE_TIMEOUT = $page_timeout || 30
    ELEMENT_TIMEOUT = $element_timeout || 15
    LOG_LEVEL = $log_level || :info
    HIGHLIGHT_VERIFICATIONS = $highlight_verifications
    HIGHLIGHT_DURATION = $highlight_duration || 0.100
    SCREENSHOT_ON_FAILURE = $screenshot_on_failure

    #
    # Add a Constant to the Config class
    #
    # @param [Symbol] constant - the constant to define within config. Ensure to use a Symbol and uppercase name
    # @param [Type]  value - the value to give the constant
    #
    def self.add_update_config_value(constant, value)
      self.const_set(constant, value)
    end

  end
end
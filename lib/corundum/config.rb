module Corundum
  module Config
    BROWSER = :firefox
    URL = 'http://www.google.com'
    PAGE_TIMEOUT = 30
    ELEMENT_TIMEOUT = 15
    LOG_LEVEL = :debug
    HIGHLIGHT_VERIFICATIONS = true
    HIGHLIGHT_DURATION = 0.100

    #
    # Add a Constant to the Config class
    #
    # @param [Symbol] constant - the constant to define within config. Ensure to use a Symbol and uppercase name
    # @param [Type]  value - the value to give the constant
    #
    def self.add_config_value(constant, value)
      self.const_set(constant, value) if !const_defined?(constant)
    end

  end
end
# Config class provides configuration hooks for tests to control aspects of runtime settings

module Corundum
  class << self
    attr_accessor :config
  end

  def self.configure
    self.config ||= Config.new
    yield config
  end

  class Config
    attr_accessor :report_dir, :target_ip, :browser, :url, :page_load_timeout, :element_timeout, :log_level
    attr_accessor :highlight_verifications, :highlight_duration, :screenshot_on_failure

    def initialize
      @report_dir = Dir.home
      @target_ip = "localhost"
      @browser = :firefox
      @url = "about:blank"
      @page_load_timeout = 30
      @element_timeout = 15
      @log_level = :info
      @highlight_verifications = false
      @highlight_duration = 0.100
      @screenshot_on_failure = false
    end
  end
end
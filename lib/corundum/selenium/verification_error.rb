require 'driver'

module Corundum::Selenium
  class VerificationError
    attr_reader :error, :screenshot_path

    #
    # @param [String] error - error message
    # @param [Boolean] take_screenshot - whether or not to take a screenshot
    def initialize(error, take_screenshot=false)
      @error = error
      @screenshot_path = nil
      if take_screenshot
        @screenshot_path = File.join(REPORT_DIR, "#{rand(10000000...99999999)}.png")
        Driver.save_screenshot(@screenshot_path)
      end
    end
  end
end

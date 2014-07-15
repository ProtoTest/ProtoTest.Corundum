require 'selenium-webdriver'

module Corundum
  module Selenium
    class Element

      def initialize(locator_type, locator)
        @driver = nil
      end

    end
  end
end
require 'selenium-webdriver'

module Corundum
  module Selenium
    class Element

      def initialize(element, *args)
        @by_type = args[0]
        @locator = args[1]
        @element = element
      end

      def method_missing(method_sym, *arguments, &block)
        puts("called #{method_sym} on element #{@locator} by #{@by_type}")
        if @element.respond_to?(method_sym)
          @element.method(method_sym).call(*arguments, &block)
        else
          super
        end
      end

    end
  end
end
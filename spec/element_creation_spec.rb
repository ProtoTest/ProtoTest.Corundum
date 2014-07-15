require 'rspec'
require 'spec_helper'
require 'corundum_context'

describe 'Corundum.element' do
  include_context 'corundum context'
  it 'should create an element' do
    class PageObject
      include Corundum

      attr_reader :test_element, :driver
      def initialize
        @test_element = element(:css, 'throwaway')
      end

    end
    one = PageObject.new
    two = PageObject.new

    puts one.driver === two.driver

    sleep 1
  #PageObject.new.test_element.should_not be_nil

  end

  it 'should also create an element' do
    class PageObject
      include Corundum

      attr_reader :test_element, :driver
      def initialize
        @test_element = element(:css, 'throwaway')
      end

    end
    one = PageObject.new
    two = PageObject.new

    puts one.driver === two.driver

    sleep 1
    #PageObject.new.test_element.should_not be_nil

  end
end
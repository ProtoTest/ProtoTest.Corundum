require 'rspec'
require 'corundum/core'
shared_context 'corundum context' do
  include Corundum
  before do
    @driver = Selenium::WebDriver.for :firefox
  end

  after do
    @driver.quit
  end
end
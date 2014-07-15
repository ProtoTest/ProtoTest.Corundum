require 'rspec'
require 'Corundum/core'
require 'Corundum/config'

shared_context 'corundum context' do
  include Corundum

  before do
    @config = CorundumConfig.new
    @driver = Selenium::WebDriver.for(@config.browser.intern)
  end

  after do
    @driver.quit
  end

end
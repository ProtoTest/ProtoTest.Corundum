require 'rspec'
require 'corundum'
include Corundum::Selenium

shared_context 'corundum context' do
   include Corundum

  # before :all do
  #   self.config = CorundumConfig.new
  #   self.session = Driver.for(config.browser.intern)
  # end

  after :each do
    puts ('>>> EXECUTING CLEANUP')
    Corundum::Selenium::Driver.quit
  end

end
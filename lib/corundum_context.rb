require 'rspec'
require 'corundum'
include Corundum::Selenium

shared_context 'corundum context' do
   include Corundum

  before :each do
    # $log.message('')
    # $log.message('Beginning new test...')
  end

  after :each do
    # $log.message('Executing test cleanup...')
    # Corundum::Selenium::Driver.quit
  end

end
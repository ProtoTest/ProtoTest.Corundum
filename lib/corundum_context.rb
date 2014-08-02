require 'rspec'
require 'corundum'
include Corundum::Selenium

shared_context 'corundum context' do
   include Corundum

  before :each do
    # Log.message('')
    # Log.message('Beginning new test...')
  end

  after :each do
    # Log.message('Executing test cleanup...')
    # Corundum::Selenium::Driver.quit
  end

end
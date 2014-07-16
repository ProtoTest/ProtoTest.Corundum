require 'rspec'
require 'corundum'
include Corundum::Selenium


shared_context 'corundum context' do
  include Corundum

  before :all do
    self.config = CorundumConfig.new
    self.session = Driver.for(config.browser.intern)
  end

  after :all do
    session.quit
  end

end
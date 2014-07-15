require 'rspec'
require 'corundum/config'
require 'corundum/core'

shared_context 'corundum context' do
  include Corundum

  before do
    Corundum.config= CorundumConfig.new
    Corundum.session= BrowserSession.new(Corundum.config.browser)
    Corundum.session.launch
  end

  after do
    @session.close
  end

end
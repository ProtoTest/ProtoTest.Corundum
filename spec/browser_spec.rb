require 'rspec'
require 'spec_helper'
require 'corundum_context'


describe 'Browser driver spec' do
  include_context 'corundum context'

  test_url = "http://prototest.com"
  test_driver = Driver

  it 'Test 001 should launch browser and url (specified by spec config) via Corundum Driver' do
    $log.info(example.description)
    site = test_url #pulls from test config (above)
    test_driver.visit(site) #Driver pulls from test config (above)
    test_driver.verify_url(site)
  end

  it 'Test 002 should launch browser and url (specified by config class) via Corundum Driver' do
    $log.info(example.description)
    site = Corundum::Config::URL #pulls from framework config
    Driver.visit(site) #Driver pulls from framework config
    Driver.verify_url(site)
  end

end
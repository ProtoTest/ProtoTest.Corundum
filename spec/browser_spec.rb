require 'spec_helper'

describe 'Browser driver spec' do
  include_context 'corundum'

  test_url = "http://prototest.com"
  test_driver = Driver

  it 'Test 001 should launch browser and url (specified by spec config)' do
    site = test_url #pulls from test config (above)
    test_driver.visit(site) #Driver pulls from test config (above)
    test_driver.verify_url(site)
  end

  it 'Test 002 should launch browser and url (specified by config class)' do
    site = Corundum::Config::URL #pulls from framework config
    Driver.visit(site) #Driver pulls from framework config
    Driver.verify_url(site)
  end

  it 'Test 003 should launch browser and url (specified by spec helper)' do
    site = $url #pulls from spec_helper config
    Driver.visit(site) #Driver pulls from framework config
    Driver.verify_url(site)
  end

end
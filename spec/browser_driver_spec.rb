require 'rspec'
require 'spec_helper'
require 'corundum_context'


describe 'Browser driver spec' do
  include_context 'corundum context'

  test_url = "http://prototest.com"
  test_driver = Driver

  it 'should launch browser and url (specified by test) via Selenium' do
    puts('>>> Test should launch browser and url (specified by test) via Selenium')
    site = "https://www.google.com"
    Driver.driver = Selenium::WebDriver.for(:firefox)
    Driver.visit(site)
    loaded = Driver.current_domain
    raise "Failed to load (#{site}).  Site loaded was (#{loaded})." if not site.include?(loaded)
  end

  it 'should launch browser and url (specified by spec config) via Corundum Driver' do
    puts('>>> Test should launch browser and url (specified by spec config) via Corundum Driver')
    site = test_url #pulls from test config (above)
    test_driver.visit(site) #Driver pulls from test config (above)
    loaded = test_driver.current_domain
    raise "Failed to load (#{site}).  Site loaded was (#{loaded})." if not site.include?(loaded)
  end

  it 'should launch browser and url (specified by config class) via Corundum Driver' do
    puts('>>> Test should launch browser and url (specified by config class) via Corundum Driver')
    site = Corundum::Config::URL #pulls from framework config
    Driver.visit(site) #Driver pulls from framework config
    sleep 5
    loaded = Driver.current_domain
    raise "Failed to load (#{site}).  Site loaded was (#{loaded})." if not site.include?(loaded)
  end

end
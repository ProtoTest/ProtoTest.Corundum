require 'rspec'
require 'spec_helper'
require 'corundum_context'


describe 'Browser driver spec' do
  include_context 'corundum context'

  test_url = "http://prototest.com"

  it 'should launch browser and url (specified by config) via Corundum Driver' do
    puts('>>> Test should launch browser and url (specified by config) via Corundum Driver')
    site = test_url #pulls from test config (above)
    Driver.visit(site) #Driver pulls from framework config
    loaded = Driver.current_url
    raise "Failed to load (#{site}).  Site loaded was (#{loaded})." if not Driver.current_url.include?(site)
  end

  it 'should launch browser and url (specified by test) via Selenium' do
    puts('>>> Test should launch browser and url (specified by test) via Selenium')
    site = "https://www.google.com"
    Driver.driver = Selenium::WebDriver.for(:firefox)
    Driver.visit(site)
    loaded = Driver.current_url
    raise "Failed to load (#{site}).  Site loaded was (#{loaded})." if not Driver.current_url.include?(site)
  end

end
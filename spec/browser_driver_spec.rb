require 'rspec'
require 'spec_helper'

describe 'Browser driver' do

  it 'should launch browser (specified by config) via Corundum Driver' do
    puts('Test should launch browser (specified by config) via Corundum Driver')
    ENV['CONFIG_FILE'] ||= 'spec/config.yaml'
    session = Driver.for($config.browser.intern)
    session.visit($config.url)
    sleep(3)
    session.quit
  end

  it 'should launch browser (specified by test) via Corundum Driver and then test an element' do
    puts('Test should launch browser (specified by test) via Corundum Driver and then test an element')
    session = Driver.for(:firefox)
    session.visit('http://www.google.com')
    sleep(3)
    input = session.find_element(:xpath, "//*[@id='gbqfq']")
    input.click
    input.send_keys('prototest')
    sleep(3)
    session.find_element(:xpath, "//cite[@class='_td']/b[text()='prototest']")
    session.close
  end

end
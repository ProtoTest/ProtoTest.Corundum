require 'rspec'
require 'spec_helper'

describe 'Browser driver spec' do

  it 'should launch browser (specified by config) via Corundum Driver' do
    puts('>>> Test should launch browser (specified by config) via Corundum Driver')
    Driver.visit(Corundum::Config::URL)
    sleep(3)
    Driver.quit
  end

  it 'should launch browser (specified by test) via Selenium' do
    site = "https://www.google.com"
    puts('>>> Test should launch browser (specified by test) via Selenium')
    Driver.driver = Selenium::WebDriver.for(:firefox)
    Driver.visit(site)
    begin
      raise "Failed to load '#{site}'" if not Driver.current_url.include?(site)
    ensure
      Driver.quit
    end
  end

end
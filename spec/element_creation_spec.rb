require 'rspec'
require 'spec_helper'
require 'page_objects/google_home'

include Corundum::Selenium

describe 'Element creation spec' do

  it 'should instantiate new Corundum Elements' do
    puts ('>>> Test should instantiate new Corundum Elements')
    Driver.visit('http://www.google.com')
    puts '>>> Typing...'
    ele1 = Element.new('ele1', :css, '#gbqfq')
    ele1.send_keys 'prototest'
    puts '>>> Confirming...'
    ele2 = Element.new('ele2', :xpath, "//cite[@class='_td']/b[text()='prototest']")
    ele2.displayed?.should be_true
    Driver.quit
  end

  it 'should use an element from a page object' do
    puts ('>>> Test should use an element from a page object')
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new
    puts '>>> Typing...'
    google_home.search('prototest')
    ele = Element.new('ele2', :xpath, "//cite[@class='_td']/b[text()='prototest']")
    puts '>>> Confirming...'
    ele.displayed?.should be_true
    # puts 'Confirming...'
    # google_home.lucky_button.displayed?.should be_false
    Driver.quit
  end

  it 'should verify the button element text is correct' do
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new
    google_home.lucky_button.verify.text("I'm Feeling Lucky")

    Driver.quit
  end

  it 'should verify the button element text is NOT correct' do
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new

    google_home.lucky_button.verify.not.text("Going back to back to cali")

    Driver.quit
  end

end
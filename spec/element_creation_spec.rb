require 'rspec'
require 'rspec-expectations'
require 'spec_helper'
require 'page_objects/google_home'
require 'corundum_context'

describe 'Element creation spec' do
  include_context 'corundum context'

  it 'should instantiate new Corundum Elements' do
    puts ">>> Test #{example.description}"
    Driver.visit('http://www.google.com')
    puts '>>> Typing...'
    ele1 = Element.new('ele1', :css, '#gbqfq')
    ele1.send_keys 'prototest'
    puts '>>> Confirming...'
    ele2 = Element.new('ele2', :xpath, "//div[@id='search']//b[contains(.,'prototest')]")
    ele2.displayed?.should be_true
  end

  it 'should use an element from a page object' do
    puts ">>> Test #{example.description}"
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new
    puts '>>> Typing...'
    google_home.search('prototest')
    ele = Element.new('ele2', :xpath, "//div[@id='search']//b[contains(.,'prototest')]")
    ele.click
    puts '>>> Confirming...'
    ele.displayed?.should be_true
  end

  it 'should verify the button element text is correct' do
    puts ">>> Test #{example.description}"
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new
    google_home.lucky_button.verify.text("I'm Feeling Lucky")
  end

  it 'should verify the button element text is (NOT) correct' do
    puts ">>> Test #{example.description}"
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new
    google_home.lucky_button.verify.not.text("I'm not Feeling Lucky...")
  end

  it 'should verify the button element text is (NOT) correct and raise error' do
    puts ">>> Test #{example.description}"
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new
    expect { google_home.lucky_button.verify.text("I'm not Feeling Lucky...") }.to raise_error
  end

  it 'should verify the button element text is correct with (NOT) verification and raise error' do
    puts ">>> Test #{example.description}"
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new
    expect { google_home.lucky_button.verify.not.text("I'm Feeling Lucky") }.to raise_error
  end

  it 'should verify the button element is present' do
    puts ">>> Test #{example.description}"
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new
    google_home.lucky_button.verify.present
  end

  it 'should verify an element not on the page is (NOT) present' do
    puts ">>> Test #{example.description}"
    Driver.visit('http://www.google.com')
    Element.new("Random element", :css, "#no_id").verify.not.present
  end

  it 'should verify the button element is visible' do
    puts ">>> Test #{example.description}"
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new
    google_home.lucky_button.verify.visible
  end

  it 'should verify an element not on the page is (NOT) visible' do
    puts ">>> Test #{example.description}"
    Driver.visit('http://www.google.com')
    Element.new("Random element", :css, "#no_id").verify.not.visible
  end

  it 'should verify the button element on page with (NOT VISIBLE) verification raises error' do
    puts ">>> Test #{example.description}"
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new
    expect { google_home.lucky_button.verify.not.visible }.to raise_error
  end

  it 'should verify the button element on page with (NOT PRESENT) verification raises error' do
    puts ">>> Test #{example.description}"
    Driver.visit('http://www.google.com')
    google_home = GoogleHome.new
    expect { google_home.lucky_button.verify.not.present }.to raise_error
  end

  it 'should verify an element not on the page with (PRESENT) verification raises error' do
    puts ">>> Test #{example.description}"
    Driver.visit('http://www.google.com')
    expect { Element.new("Random element", :css, "#no_id").verify.visible }.to raise_error
  end

  it 'should verify an element not on the page with (VISIBLE) verification raises error' do
    puts ">>> Test #{example.description}"
    Driver.visit('http://www.google.com')
    expect { Element.new("Random element", :css, "#no_id").verify.present }.to raise_error
  end

end
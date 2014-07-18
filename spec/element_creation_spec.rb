require 'rspec'
require 'spec_helper'
require 'page_objects/google_home'

describe 'Corundum.element' do
  include_context 'corundum context'

  it 'should instantiate new Corundum Core elements' do
    puts ('Test should instantiate new Corundum Core elements')
    visit('http://www.google.com')
    ele1 = element(:css, '#gbqfq')
    ele1.send_keys 'prototest'
    sleep(3)
    ele2 = element(:xpath, "//cite[@class='_td']/b[text()='prototest']")
    ele2.displayed?
  end

  it 'should use an element from a page object' do
    visit('http://www.google.com')
    one = GoogleHome.new
    one.search 'prototest'
    sleep(3)
    ele = element(:xpath, "//cite[@class='_td']/b[text()='prototest']")
    ele.displayed?
  end

end
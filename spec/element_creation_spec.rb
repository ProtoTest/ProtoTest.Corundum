require 'rspec'
require 'spec_helper'
require 'page_objects/google_home'

describe 'Corundum.element' do
  include_context 'corundum context'

  it 'should instantiate a new element' do
    visit('http://www.google.com')
    ele = element(:css, '#gbqfq')
    ele.send_kees "woop woop"
  end

  it 'should create an element' do
    one = GoogleHome.new
    one.search 'monkies'
    log.info
    log.debug("oh no!", :screenshot => true)
    sleep 5
  end

end
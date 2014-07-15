require 'rspec'
require 'page_objects/google_home'
require 'corundum_context'

describe 'Corundum.element' do
  include_context 'corundum context'
  it 'should instantiate a new element' do
    ele = Element.new(:xpath, "//*[@id='stuff'")
  end

  it 'should create an element' do
    one = GoogleHome.new
    one.search 'monkies'
    sleep 5
  end

end
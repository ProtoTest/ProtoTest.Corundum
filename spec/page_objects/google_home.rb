# require 'spec_helper'
require 'corundum'

class GoogleHome
  include Corundum
  attr_reader :search_box, :lucky_button

  def initialize
    @search_box = element(:css, 'input.gbqfif')
    @lucky_button = element(:css, '#gbqfq')
  end

  def search(text)
    @search_box.send_keys(text)
  end

end

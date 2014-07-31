require 'corundum'

class GoogleHome
  attr_reader :search_box, :lucky_button

  def initialize
    @search_box = Element.new('search box', :css, 'input.gbqfif')
    @lucky_button = Element.new('lucky button', :css, '#gbqfbb')
  end

  def search(text)
    $log.info("Searching for #{text} using Google search field...")
    @search_box.send_keys(text)
  end

end

require 'corundum'

class GoogleHome < Corundum
  attr_reader :search_box, :lucky_button

  def initialize
    @search_box = element(:css, 'input.gbqfif')
    @lucky_button = element(:xpath, '//*[@id="gbqfsb"]')
  end

end

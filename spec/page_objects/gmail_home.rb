require 'corundum'

class GmailHome
  attr_reader :nav_gmail_icon

  def initialize
    @nav_gmail_icon = Element.new('Nav menu gmail icon', :xpath, "//ul[@id='nav']//span[@id='gmail-icon']")
  end

end

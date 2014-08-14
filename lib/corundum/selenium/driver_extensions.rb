# Driver Extensions class expands basic driver functionality

module Corundum
  module Selenium
  end
end

include Corundum

class Corundum::DriverExtensions

  def self.open_new_window(url)
    Driver.execute_script_driver("window.open('#{url}')")
    sleep 1
  end

  def self.close_window
    Driver.execute_script_driver("window.close()")
    sleep 1
  end

end
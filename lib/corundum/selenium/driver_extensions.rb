
module Corundum
  module Selenium
  end
end

include Corundum

class Corundum::DriverExtensions

  def self.highlight(element)
    $log.debug("Highlighting element...")
    original_border = Driver.execute_script("return arguments[0].style.border", element.element)
    original_background = Driver.execute_script("return arguments[0].style.backgroundColor", element.element)
    Driver.execute_script("arguments[0].style.border='3px solid lime'; return;", element.element)
    Driver.execute_script("arguments[0].style.backgroundColor='lime'; return;", element.element)
    sleep (Corundum::Config::HIGHLIGHT_DURATION)
    Driver.execute_script("arguments[0].style.border='" + original_border + "'; return;", element.element)
    Driver.execute_script("arguments[0].style.backgroundColor='" + original_background + "'; return;", element.element)
  end

end
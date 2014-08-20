# Element Extensions class expands specific driver commands to provide advanced functionality for Elements
# Test formatting of element: element.verify.present   Element class usage: ElementExtensions.highlight(self)

module Corundum
  module Selenium
  end
end

include Corundum

class Corundum::ElementExtensions

  def self.highlight(element)
    Log.debug("Highlighting element...")
    original_border = Driver.execute_script("return arguments[0].style.border", element.element)
    original_background = Driver.execute_script("return arguments[0].style.backgroundColor", element.element)
    Driver.execute_script("arguments[0].style.border='3px solid lime'; return;", element.element)
    Driver.execute_script("arguments[0].style.backgroundColor='lime'; return;", element.element)
    sleep (Corundum.config.highlight_duration)
    Driver.execute_script("arguments[0].style.border='" + original_border + "'; return;", element.element)
    Driver.execute_script("arguments[0].style.backgroundColor='" + original_background + "'; return;", element.element)
  end

  def self.scroll_to(element)
    Log.debug("Scrolling element into view...")
    Driver.execute_script("arguments[0].scrollIntoView(); return;", element.element)
    sleep 1
  end

  def self.hover_over(element)
    Driver.execute_script("var evObj = document.createEvent('MouseEvents'); evObj.initMouseEvent(\"mouseover\",true, false, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null); arguments[0].dispatchEvent(evObj);", element.element)
    sleep 2
  end

  def self.hover_away(element)
    Driver.execute_script("var evObj = document.createEvent('MouseEvents'); evObj.initMouseEvent(\"mouseout\",true, false, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null); arguments[0].dispatchEvent(evObj);", element.element)
    sleep 1
  end

end
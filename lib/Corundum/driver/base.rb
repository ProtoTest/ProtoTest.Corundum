#
# Methods on standby in case a non-selenium driver needs to be implemented
#

module Corundum
  module Driver
  end
end

class Corundum::Driver::Base

  def current_url
    raise NotImplementedError
  end

  def visit(path)
    raise NotImplementedError
  end

  def html
    raise NotImplementedError
  end

  def go_back
    raise NotImplementedError
  end

  def go_forward
    raise NotImplementedError
  end

  def execute_script(script)
    raise NotImplementedError
  end

  def evaluate_script(script)
    raise NotImplementedError
  end

  def save_screenshot(path, options={})
    raise NotImplementedError
  end

  def within_frame(frame_handle)
    raise NotImplementedError
  end

  def current_window_handle
    raise NotImplementedError
  end

  def window_size(handle)
    raise NotImplementedError
  end

  def resize_window_to(handle, width, height)
    raise NotImplementedError
  end

  def maximize_window(handle)
    raise NotImplementedError
  end

  def close_window(handle)
    raise NotImplementedError
  end

  def window_handles
    raise NotImplementedError
  end

  def open_new_window
    raise NotImplementedError
  end

  def switch_to_window(handle)
    raise NotImplementedError
  end

  def within_window(locator)
    raise NotImplementedError
  end

  def no_such_window_error
    NotImplementedError
  end

end
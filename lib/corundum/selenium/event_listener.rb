class LogDriverEventsListener
  def call *args
    # only need to deal with the hooks you are interested in
    case args.first
      when :before_navigate_to
        puts "Navigating to url: #{args[1]}"
      when :before_quit
        puts "Shutting down web driver"
    end
  end
end

Selenium::WebDriver::Element
# require 'corundum'
#
# class DriverEventsListener
#
#   def call (*args)
#     # only need to deal with the hooks you are interested in
#     case args.first
#       when :before_navigate_to
#         $log.debug("Navigating to url: #{args[1]}")
#       when :before_quit
#         $log.debug("Shutting down web driver...")
#     end
#   end
#
# end

require 'rspec/core/formatters/html_formatter'

class CustomFormatter < RSpec::Core::Formatters::HtmlFormatter

  # Overrides the Rspec method in order to inject extra content during a spec pass
  def example_group_started(example)
    html = ''
    # Buffer space
    html << '<table border="0" title="Buffer space">'
    html << '<th><td height="5"></td></th>'
    html << '</table>'
    #Add Suite Output files
    html << '<table border="1" cellpadding="10" style="font-size:12px; border-collapse:collapse;"><th>Suite Output Files (All specs)</th>'
    html << '<tr><td><a href="spec_execution_notes.txt">Spec Execution Notes</a></td></tr>'
    html << '<tr><td><a href="spec_execution_stats.xml">Spec Execution Stats</a></td></tr>'
    html << '<tr><td><a href="spec_logging_output.log">Spec Logging Output</a></td></tr>'
    html << '</table>'
    # Buffer space
    html << '<table border="0" title="Buffer space">'
    html << '<th><td height="5"></td></th>'
    html << '</table>'
    super << html
  end

  # Overrides the Rspec method in order to inject extra content during a spec pass
  def example_passed(example)
    html = ''
    html << add_screenshots_pass_html
    super << html
  end

  def add_screenshots_pass_html
    screenshot_html = ''
    $screenshots_captured.each { |shot|
      screenshot_html << '<table border="1" cellpadding="10" style="font-size:12px; border-collapse:collapse;"><th>Screenshot captured during execution of above spec</th>'
      screenshot_html << "<tr><td><center>Screenshot name: (#{shot})</center></td></tr>"
      screenshot_html << "<tr><td><a href=#{shot}><img src=#{shot} style='max-width:800px;'></img></a></td></tr>"
      screenshot_html << '</table>'
      screenshot_html << '<table border="0" title="Buffer space">'
      screenshot_html << '<th><td height="10"></td></th>'
      screenshot_html << '</table>'
    }
    screenshot_html
  end

  # Overrides the Rspec method in order to inject extra content during a spec failure
  def extra_failure_content(failure)
    html = ''
    html << add_screenshots_fail_html
    #Final failure
    if Corundum.config.screenshot_on_failure
      html << '<table border="1" cellpadding="10" style="font-size:12px; border-collapse:collapse;"><th>Final screenshot captured during spec failure</th>'
      html << "<tr><td><center>Screenshot name: (#{@final_screenshot})</center></td></tr>"
      html << "<tr><td><a href=#{@final_screenshot}><img src=#{@final_screenshot} style='max-width:800px;'></img></a></td></tr>"
      html << '</table>'
      html << add_buffer_space_html
    else
      html << '<table border="1" cellpadding="10" style="font-size:12px; border-collapse:collapse;"><th>(Final screenshot on failure) config value set to (false)</th>'
      html << '</table>'
      html << add_buffer_space_html
    end
    super + html
  end

  def add_screenshots_fail_html
    screenshot_of_failure_html = ''
    @final_screenshot = $screenshots_captured.last
    #Removes the last item from the array (last entry is final failure)
    $screenshots_captured.reverse.drop(1).reverse.each { |shot|
      screenshot_of_failure_html << '<table border="1" cellpadding="10" style="font-size:12px; border-collapse:collapse;"><th>Screenshot captured during execution of above spec</th>'
      screenshot_of_failure_html << "<tr><td><center>Screenshot name: (#{shot})</center></td></tr>"
      screenshot_of_failure_html << "<tr><td><a href=#{shot}><img src=#{shot} style='max-width:800px;'></img></a></td></tr>"
      screenshot_of_failure_html << '</table>'
      screenshot_of_failure_html << add_buffer_space_html
    }
    screenshot_of_failure_html
  end

  def add_buffer_space_html
    buffer_space_html = '<table border="0" title="Buffer space">'
    buffer_space_html << '<th><td height="10"></td></th>'
    buffer_space_html << '</table>'
    buffer_space_html
  end

end
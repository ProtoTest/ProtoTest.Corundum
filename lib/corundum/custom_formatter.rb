require 'rspec/core/formatters/html_formatter'

class CustomFormatter < RSpec::Core::Formatters::HtmlFormatter

  # Overrides the Rspec method in order to inject extra content during a spec pass
  def example_passed(example)
    # Buffer space
    @html = '<table border="0" title="Buffer space">'   #Leading @html statement has to contain '=' sign to signal beginning of HTML content
    @html << '<th><td height="10"></td></th>'
    @html << '</table>'

    add_screenshots_captured_pass

    add_suite_output_files

    super << @html
  end

  # Overrides the Rspec method in order to inject extra content during a spec failure
  def extra_failure_content(failure)

    # Buffer space
    @html = '<table border="0" title="Buffer space">'   #Leading @html statement has to contain '=' sign to signal beginning of HTML content
    @html << '<th><td height="10"></td></th>'
    @html << '</table>'

    add_screenshots_captured_fail

    #Final failure
    if Corundum.config.screenshot_on_failure
      @html << '<table border="1" cellpadding="10" style="font-size:12px; border-collapse:collapse;"><th>Final screenshot captured during spec failure</th>'
      @html << "<tr><td><center>Screenshot name: (#{@final_screenshot})</center></td></tr>"
      @html << "<tr><td><a href=#{@final_screenshot}><img src=#{@final_screenshot} style='max-width:800px;'></img></a></td></tr>"
      @html << '</table>'
      buffer_space
    else
      @html << '<table border="1" cellpadding="10" style="font-size:12px; border-collapse:collapse;"><th>(Final screenshot on failure) config value set to (false)</th>'
      @html << '</table>'
      buffer_space
    end

    add_suite_output_files

    super + @html
  end

  def add_screenshots_captured_pass
    $screenshots_captured.each { |shot|
      @html << '<table border="1" cellpadding="10" style="font-size:12px; border-collapse:collapse;"><th>Screenshot captured during execution of above spec</th>'
      @html << "<tr><td><center>Screenshot name: (#{shot})</center></td></tr>"
      @html << "<tr><td><a href=#{shot}><img src=#{shot} style='max-width:800px;'></img></a></td></tr>"
      @html << '</table>'
      buffer_space
    }
  end

  def add_screenshots_captured_fail

    @final_screenshot = $screenshots_captured.last

    #Removes the last item from the array (last entry is final failure)
    $screenshots_captured.reverse.drop(1).reverse.each { |shot|
      @html << '<table border="1" cellpadding="10" style="font-size:12px; border-collapse:collapse;"><th>Screenshot captured during execution of above spec</th>'
      @html << "<tr><td><center>Screenshot name: (#{shot})</center></td></tr>"
      @html << "<tr><td><a href=#{shot}><img src=#{shot} style='max-width:800px;'></img></a></td></tr>"
      @html << '</table>'
      buffer_space
    }
  end

  def add_suite_output_files
    #Output files
    @html << '<table border="1" cellpadding="10" style="font-size:12px; border-collapse:collapse;"><th>Suite Output Files (All specs)</th>'
    @html << '<tr><td><a href="spec_execution_notes.txt">Spec Execution Notes</a></td></tr>'
    @html << '<tr><td><a href="spec_execution_stats.xml">Spec Execution Stats</a></td></tr>'
    @html << '<tr><td><a href="spec_logging_output.log">Spec Logging Output</a></td></tr>'
    @html << '</table>'
    buffer_space
  end

  def buffer_space
    @html << '<table border="0" title="Buffer space">'
    @html << '<th><td height="10"></td></th>'
    @html << '</table>'
  end

end
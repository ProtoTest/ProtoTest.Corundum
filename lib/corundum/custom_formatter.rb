require 'rspec/core/formatters/html_formatter'

class CustomFormatter < RSpec::Core::Formatters::HtmlFormatter

  # Overrides the Rspec method in order to inject extra content during a spec pass
  def example_passed(example)
    # # Buffer space
    @html = '<table border="0" title="Buffer space">'
    @html << '<th></th>'
    @html << '</table>'

    $screenshots_captured.each { |shot|
      @html << '<table border="1" cellpadding="10" style="font-size:12px; border-collapse:collapse;"><th>Screenshot captured during execution of above spec</th>'
      @html << "<tr><td><a href=#{shot}><img src=#{shot} style='max-width:800px;'></img></a></td></tr>"
      @html << '</table>'
      # Buffer space
      @html << '<table border="0" title="Buffer space">'
      @html << '<th></th>'
      @html << '</table>'
    }

    super << @html
  end

  # Overrides the Rspec method in order to inject extra content during a spec failure
  def extra_failure_content(failure)

    if Corundum.config.screenshot_on_failure
      @html = '<table border="1" cellpadding="10" style="font-size:12px; border-collapse:collapse;"><th>Screenshot captured during spec failure</th>'
      @html << "<tr><td><a href=#{shot}><img src=#{$fail_screenshot} style='max-width:800px;'></img></a></td></tr>"
      @html << '</table>'
    else
      @html = '<table border="1" cellpadding="10" style="font-size:12px; border-collapse:collapse;"><th>(Screenshot on failure) config value set to (false)</th>'
      @html << '</table>'
    end

    # Buffer space
    @html << '<table border="0" title="Buffer space">'
    @html << '<th></th>'
    @html << '</table>'

    # @html << '<table border="0" cellpadding="5" bgcolor="#000000">'
    # @html << '<th>Verification Failures</th>'
    # # Corundum::Log.each { |x| @html << '<tr><td style="color:' + x.color + '">' + x.text + '</td></tr>'  }
    # $verification_errors.each do |error|
    #   @html << "<tr><td>#{error.error}</td></tr>"
    #   @html << "<tr><td><div style='width: 800px'><img  src='#{error.screenshot_path}'/></div></td></tr>"
    # end
    # @html << '</table>'

    # Buffer space
    @html << '<table border="0" title="Buffer space">'
    @html << '<th></th>'
    @html << '</table>'

    @html << '<table border="1" cellpadding="10" style="font-size:12px; border-collapse:collapse;"><th>Suite Output Files (All specs)</th>'
    @html << '<tr><td><a href="spec_execution_notes.txt">Spec Execution Notes</a></td></tr>'
    @html << '<tr><td><a href="spec_execution_stats.xml">Spec Execution Stats</a></td></tr>'
    @html << '<tr><td><a href="spec_logging_output.log">Spec Logging Output</a></td></tr>'
    @html << '</table>'

    # Buffer space
    @html << '<table border="0" title="Buffer space">'
    @html << '<th></th>'
    @html << '</table>'

    super + @html
  end
end
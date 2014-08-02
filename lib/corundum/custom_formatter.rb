require 'rspec/core/formatters/html_formatter'

# TODO: implement me!
class CustomFormatter < RSpec::Core::Formatters::HtmlFormatter
  def extra_failure_content(failure)
    @html = '<table border="1">'
    @html << '<th>Verification Failures</th>'
    #Logger.log.each { |x| @html << '<tr><td style="color:' + x.color + '">' + x.text + '</td></tr>'  }
    $verification_errors.each do |error|
      @html << "<tr><td>#{error.error}</td></tr>"
      @html << "<tr><td><div style='width: 800px'><img  src='#{error.screenshot_path}'/></div></td></tr>"
    end
    @html << '</table><table border="1"><th>Test Artifacts</th>'
    #@html << '<tr><td><a href="screenshot_' + RSpec.configuration.test_name + '.html">Source Html</a></td></tr>'
    #@html << '<tr><td><a href="output.txt">Documentation</a></td></tr>'
    @html << '</span></table>'
    super + @html

  end

end
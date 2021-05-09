require_relative  'personality_result_html_to_json'
require_relative  'http_request'

class ParameterMissingException < RuntimeError
  def initialize
    super("Must pass the personality result test file as parameter")
  end
end

raise ParameterMissingException if ARGV[0].nil?

html_file = ARGV[0]

result = PersonalityResultHtmlToJson.new(html_file).execute

HttpRequest.request(result)

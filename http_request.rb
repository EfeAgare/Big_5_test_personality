require 'json'
require 'uri'
require 'net/http'
require_relative 'constant'

class HttpRequest
  def self.request(result)
    uri = URI(HTTP_URL)
    res = Net::HTTP.post(uri, JSON.pretty_generate(result), "Content-Type" => "application/json")
    puts res.code
    puts res.body
  end
end


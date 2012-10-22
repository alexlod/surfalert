require 'uri'
require 'net/https'

module WundergroundApiClient
  def fetch_json_for_zip(zip)
    url = "http://api.wunderground.com/api/#{ENV['WUNDERGROUND_API_KEY']}/conditions/q/#{zip}.json"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    raise "HTTP request returned with bad status: #{response.code}" unless response.code == "200"
    return json = ActiveSupport::JSON.decode(response.body)
  end
end
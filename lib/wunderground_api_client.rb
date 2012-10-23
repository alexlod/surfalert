require 'json_api_client'

class WundergroundApiClient < JsonApiClient
  def fetch_json_for_zip(zip)
    return fetch_json_from_url("http://api.wunderground.com/api/#{ENV['WUNDERGROUND_API_KEY']}/conditions/q/#{zip}.json")
  end
end

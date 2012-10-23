require 'json_api_client'

class SpitcastApiClient < JsonApiClient
  # e.g., "san-francisco"
  def fetch_json_for_county(county)
    return fetch_json_from_url("http://www.spitcast.com/api/county/spots/#{county}/")
  end
end

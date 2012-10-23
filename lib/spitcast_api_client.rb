require 'json_api_client'

class SpitcastApiClient < JsonApiClient
  # Returns a JSON object representing the current surf for a county and spot ID.
  #
  # The county should be url-formatted, e.g., "san-francisco".
  # The spot ID is specific to spitcast.
  def fetch_json_for_county_and_spot_id(county, spot_id)
    fetch_json_from_url("http://www.spitcast.com/api/county/spots/#{county}/").each do |spot|
      return spot if spot["spot_id"].to_i == spot_id
    end
    return nil
  end
end

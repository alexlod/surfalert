require 'spitcast_api_client'

class SurfEvaluator

  def check_surf_conditions(county, spot_id)
    spitcast = SpitcastApiClient.new
    surf_json = spitcast.fetch_json_for_county_and_spot_id(county, spot_id)

    avg_size = surf_json["avgSize"]
    if avg_size > 6 and avg_size < 9
      msg = "Wake your ass up, the surf is pumping! Size of surf: " + 
            surf_json["minSize"].to_s + "' to " + surf_json["maxSize"].to_s + "'"
      return true, msg
    else
      msg = "Conditions could be better... Size of surf: " +
            surf_json["minSize"].to_s + "' to " + surf_json["maxSize"].to_s + "'"
      return false, msg
    end
  end
end

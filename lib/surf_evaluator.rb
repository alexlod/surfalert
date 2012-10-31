require 'spitcast_api_client'

class SurfEvaluator

  def check_surf_conditions(surf_preference)
    spitcast = SpitcastApiClient.new
    surf_json = spitcast.fetch_json_for_county_and_spot_id('san-francisco', surf_preference.spot_id)

    min_size = surf_json["minSize"]
    max_size = surf_json["maxSize"]
    if min_size > surf_preference.min_size and max_size < surf_preference.max_size
      msg = "Wake your ass up, the surf is pumping! Size of surf: " + 
            min_size.to_s + "' to " + max_size.to_s + "'"
      return true, msg
    else
      msg = "Conditions could be better... Size of surf: " +
            min_size.to_s + "' to " + max_size.to_s + "'"
      return false, msg
    end
  end
end

require 'spitcast_api_client'

class SurfEvaluator

  # checks the current conditions for the given `SurfPreference` and returns true
  # if the surf is good enough for an alert.  False is returned otherwise.
  #
  # When true is returned, a message is also returned that contains information
  # about the surf.
  def check_surf_conditions(surf_preference)
    spitcast = SpitcastApiClient.new
    surf_json = spitcast.fetch_json_for_county_and_spot_id('san-francisco', surf_preference.spot_id)

    min_size = surf_json["minSize"]
    max_size = surf_json["maxSize"]
    min_shape = surf_json["minShape"]
    # we want the desired max size (from the API) to be getween the desired min and max.
    if max_size >= surf_preference.min_size and max_size <= surf_preference.max_size and
       surf_preference.shape_good_enough?(min_shape)
      msg = "Wake your ass up, the surf is pumping " + 
            "at #{SurfPreference::SPOTS[surf_preference.spot_id]}! " +
            min_size.to_s + "-" + max_size.to_s + "ft, " +
            SurfPreference::SHAPES[min_shape]
      return true, msg
    else
      return false, nil
    end
  end
end

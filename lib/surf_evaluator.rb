require 'spitcast_api_client'
require 'time'

class SurfEvaluator

  def check_surf_conditions(surf_json, surf_preference)
    min_size = surf_json["minSize"]
    max_size = surf_json["maxSize"]
    current_time = Time.now.strftime("%H%M").to_i
    start_i = surf_preference.start.strftime("%H%M").to_i
    end_i = surf_preference.end.strftime("%H%M").to_i

    puts min_size.to_s + " > " + surf_preference.min_size.to_s
    puts max_size.to_s + " < " + surf_preference.max_size.to_s
    puts surf_preference.shape_good_enough?(surf_json["avgShape"]).to_s
    puts (current_time >= start_i).to_s
    puts (current_time <= end_i).to_s

    if min_size >= surf_preference.min_size and 
       max_size <= surf_preference.max_size and
       surf_preference.shape_good_enough?(surf_json["avgShape"]) and
       current_time >= start_i and
       current_time <= end_i

      msg = "Surf size is " + min_size.to_s + "' to " + max_size.to_s + "'"
      return true, msg
    else
      msg = "Conditions could be better... Size of surf: " +
            min_size.to_s + "' to " + max_size.to_s + "'"
      return false, msg
    end
  end

  def evaluate_all_prefs()
    spitcast = SpitcastApiClient.new

    evaluated_users = {}
    preamble = "Wake your ass up, the surf is pumping!"
    SurfPreference::SPOTS.each do |id, name|
      surf_json = spitcast.fetch_json_for_county_and_spot_id('san-francisco', id)
      SurfPreference.where(:spot_id => id).find_each do |pref|
        puts "Checking conditions on " + pref.to_s
        passed, msg = check_surf_conditions(surf_json, pref)
        if passed
          user = pref.user
          msg = "\n" + name + " - " + msg
          if evaluated_users.has_key?(user)
            evaluated_users[user] += msg 
          else
            evaluated_users[user] = preamble + msg
          end
        end
      end
    end

    return evaluated_users
  end
end

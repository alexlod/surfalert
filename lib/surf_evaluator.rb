require 'spitcast_api_client'
require 'time'

class SurfEvaluator

  def evaluate_all_prefs()
    spitcast = SpitcastApiClient.new

    evaluated_users = {}
    preamble = "Wake your ass up, the surf is pumping!"
    SurfPreference::SPOTS.each do |id, name|
      surf_json = spitcast.fetch_json_for_county_and_spot_id('san-francisco', id)
      Rails.logger.debug surf_json
      SurfPreference.where(:spot_id => id).find_each do |pref|
        Rails.logger.debug "Checking conditions on " + pref.to_s
        passed, msg = pref.check_surf_conditions(surf_json)
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

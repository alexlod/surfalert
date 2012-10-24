require 'twilio_api_client'
require 'wunderground_api_client'
require 'spitcast_api_client'

desc "Looks at the weather and surf API and sends an SMS if they're good."
task :check_and_send => :environment do
  wunderground = WundergroundApiClient.new
  spitcast = SpitcastApiClient.new
  twilio = TwilioApiClient.new
  
  # northern ocean beach.
  puts spitcast.fetch_json_for_county_and_spot_id("san-francisco", 114)
  
  # 94121 is the outer richmond zip code.
  puts wunderground.fetch_json_for_zip(94121)
  
  # TODO: don't hard code the conditions -- fetch conditions from APIs.
  twilio.send_sms_message(
    ENV["TWILIO_FROM_NUMBER"], 
    ENV["TWILIO_TO_NUMBER"],
    "Wake your ass up, the surf is pumping! Conditions: good 7-8ft"
  )
 end

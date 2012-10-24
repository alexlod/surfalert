require 'twilio_api_client'
require 'wunderground_api_client'
require 'surf_evaluator'

desc "Looks at the weather and surf API and sends an SMS if they're good."
task :check_and_send => :environment do
  wunderground = WundergroundApiClient.new
  twilio = TwilioApiClient.new
  surf_evaluator = SurfEvaluator.new
  
  # northern ocean beach.
  conditions, msg = surf_evaluator.check_surf_conditions("san-francisco", 114)
  
  # 94121 is the outer richmond zip code.
  puts wunderground.fetch_json_for_zip(94121)
  
  # TODO: don't hard code the conditions -- fetch conditions from APIs.
  if conditions
    twilio.send_sms_message(
      ENV["TWILIO_FROM_NUMBER"], 
      ENV["TWILIO_TO_NUMBER"],
      msg
    )
  else
    puts "Not sending SMS. " + msg
  end
end

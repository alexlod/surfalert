require 'twilio_api_client'
require 'wunderground_api_client'
require 'surf_evaluator'

desc "Looks at the weather and surf API and sends an SMS if they're good."
task :check_and_send => :environment do
  wunderground = WundergroundApiClient.new
  twilio = TwilioApiClient.new
  surf_evaluator = SurfEvaluator.new
  
  # TODO: make this not spam people
  users_to_sms = surf_evaluator.evaluate_all_prefs()
  users_to_sms.each do |user, msg|
    twilio.send_sms_message(
      ENV["TWILIO_FROM_NUMBER"], 
      user.phone_no,
      msg
    )
  end
end

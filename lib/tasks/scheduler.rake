require 'twilio_api_client'
require 'surf_evaluator'

desc "Looks at the weather and surf API and sends an SMS if they're good."
task :check_and_send => :environment do
  twilio = TwilioApiClient.new
  surf_evaluator = SurfEvaluator.new
  
  surf_preference = SurfPreference.find(1)
  conditions, msg = surf_evaluator.check_surf_conditions(surf_preference)

  if conditions
    twilio.send_sms_message(
      ENV["TWILIO_FROM_NUMBER"], 
      surf_preference.phone_no,
      msg
    )
  end
end

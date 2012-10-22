require 'twilio-ruby'
require 'wunderground_api_client'

def send_sms(conditions)
  @account_sid = ENV["TWILLIO_ACCOUNT_SID"]
  @auth_token = ENV["TWILLIO_SECRET"]

  # set up a client to talk to the Twilio REST API
  @client = Twilio::REST::Client.new(@account_sid, @auth_token)


  @account = @client.account
  @message = @account.sms.messages.create({
    :from => ENV["TWILLIO_FROM_NUMBER"],
    :to => ENV["TWILLIO_TO_NUMBER"],
    :body => "Wake your ass up, the surf is pumping! Conditions: #{conditions}"
  })
end

desc "Looks at the weather and surf API and sends an SMS if they're good."
task :check_and_send => :environment do
  include WundergroundApiClient
  
  # TODO: use the spitcast API too: http://www.spitcast.com/api/docs/
  
  # 94122 is the outer sunset zip code.
  puts fetch_json_for_zip(94122)
  
  # TODO: don't hard code the conditions -- fetch conditions from APIs.
  send_sms("good 7-8ft")
end
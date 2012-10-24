require 'twilio-ruby'
require 'wunderground_api_client'
require 'spitcast_api_client'

def send_sms(to_number, conditions)
  @account_sid = ENV["TWILLIO_ACCOUNT_SID"]
  @auth_token = ENV["TWILLIO_SECRET"]

  # set up a client to talk to the Twilio REST API
  @client = Twilio::REST::Client.new(@account_sid, @auth_token)


  @account = @client.account
  @message = @account.sms.messages.create({
    :from => ENV["TWILLIO_FROM_NUMBER"],
    :to => to_number,
    :body => "Wake your ass up, the surf is pumping! Conditions: #{conditions}"
  })
end

desc "Looks at the weather and surf API and sends an SMS if they're good."
task :check_and_send => :environment do
  wunderground = WundergroundApiClient.new
  spitcast = SpitcastApiClient.new
  
  # northern ocean beach.
  puts spitcast.fetch_json_for_county_and_spot_id("san-francisco", 114)
  
  # 94121 is the outer richmond zip code.
  puts wunderground.fetch_json_for_zip(94121)
  
  # TODO: don't hard code the conditions -- fetch conditions from APIs.
  send_sms(ENV["TWILLIO_TO_NUMBER"], "good 7-8ft")
end
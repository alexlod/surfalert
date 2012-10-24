require 'twilio-ruby'

class TwilioApiClient

  def create_client()
    @client = Twilio::REST::Client.new "#{ENV['TWILIO_ACCOUNT_SID']}", "#{ENV['TWILIO_SECRET']}"
  end

  def send_sms_message(from, to, message)
    puts "Sending a message from " + from + " to " + to + ": " + message
    @client.account.sms.messages.create(
      :from => from,
      :to => to,
      :body => message
    )
  end
end

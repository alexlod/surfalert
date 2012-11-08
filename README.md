Rails app that uses APIs to check if the surf is good and send a SMS to wake someone up.

## Setup

Setup your env with the following variables:

 * **TWILIO_ACCOUNT_SID** -- Twilio Account SID
 * **TWILIO_SECRET**= -- Twilio secret token
 * **TWILIO_FROM_NUMBER** -- number to send SMSes from (the Twilio number)
 * **TWILIO_TO_NUMBER** -- number to send SMSes to
 * **WUNDERGROUND_API_KEY** -- wunderground.com API key
 * **AUTH_USERNAME** -- a username to do HTTP authentication because for now we'll keep things simple and password-off the whole site.
 * **AUTH_PASSWORD** -- a password for HTTP authentication

Setup `config/database.yml` with a development and test database.

Run `$ rake db:migrate` to setup your database.

Run `$ rake check_and_send` to check the surf and send a SMS if appropriate.

## Running tests

Run `$ rake spec`

## Current Status

This app is in development.  Do not expect it to work.

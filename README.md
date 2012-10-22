Rails app that uses APIs to check if the surf is good and send a SMS to wake someone up.

## Setup

Setup your env with the following variables:

 * **TWILLIO_ACCOUNT_SID** -- Twillio Account SID
 * **TWILLIO_SECRET**= -- Twillio secret token
 * **TWILLIO_FROM_NUMBER** -- number to send SMSes from (the Twillio number)
 * **TWILLIO_TO_NUMBER** -- number to send SMSes to
 * **WUNDERGROUND_API_KEY** -- wunderground.com API key

Run `$ rake check_and_send` to check the surf and send a SMS if appropriate.

## Current Status

This app is in development.  Do not expect it to work.

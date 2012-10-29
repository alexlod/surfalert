class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :basic_auth
  
  protected
  
    # use as a `before_filter` to do a basic HTTP auth.  Credentials
    # are taken from the environment.
    def basic_auth
      authenticate_or_request_with_http_basic do |username, password|
        username == ENV["AUTH_USERNAME"] && ENV["AUTH_PASSWORD"]
      end
    end
end
